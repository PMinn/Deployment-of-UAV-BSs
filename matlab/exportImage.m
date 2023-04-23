function exportImage(locationOfUEs, UAVBSsSet, r_UAVBS)
    clf(gcf);
    set(gcf,'outerposition',get(0,'screensize')); % 視窗最大
    set(gcf,'visible','off');
    set(gca, 'Color','#FDFDFD');
    hold on;
    boundaryUEsSet = convhull(locationOfUEs); % 凸包上的UE集合
    xArrayFromLocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromLocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列
    plot(xArrayFromLocationOfUEs(boundaryUEsSet), yArrayFromLocationOfUEs(boundaryUEsSet), 'Color', '#242424', 'LineStyle', "--"); % 邊界線

    % for i=1:size(UAVBSsRange,2)
    %     % UEs所屬的UAVBS
    %     for j=1:size(UAVBSsRange{1,i},1)
    %         text(UAVBSsRange{1,i}(j,1), UAVBSsRange{1,i}(j,2),'\leftarrow ' + string(i));
    %     end
    % end

    % 連接線
    for i=1:size(UAVBSsSet,1)-1
        x = transpose(UAVBSsSet(i:i+1,1));
        y =  transpose(UAVBSsSet(i:i+1,2));
        line(x, y, 'Color', '#D7433D', 'Linestyle', '-');
    end


    % UAVBSs的範圍
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        rectangle('Position', [x-r_UAVBS,y-r_UAVBS,2*r_UAVBS,2*r_UAVBS], 'Curvature', [1,1], 'EdgeColor', '#5DAE7E', 'LineWidth', 1);
    end
    scatter(UAVBSsSet(:,1), UAVBSsSet(:,2), 80, "filled", "square", 'MarkerFaceColor', '#5DAE7E'); % 所有UAVBSs的點
    scatter(xArrayFromLocationOfUEs, yArrayFromLocationOfUEs, 20, "filled", "^", 'MarkerEdgeColor', '#2F5A91', 'MarkerFaceColor', '#2F5A91'); % 所有UEs的點
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        text(x, y, string(i)+' ', 'HorizontalAlignment', 'right', 'FontSize', 14, 'FontWeight', 'bold', 'Color', '#242424');
    end
    axis equal;
    minPosition = min(locationOfUEs);
    maxPosition = max(locationOfUEs);
    axis([minPosition(1,1)-r_UAVBS maxPosition(1,1)+r_UAVBS minPosition(1,2)-r_UAVBS maxPosition(1,2)+r_UAVBS]); % axis([xmin,xmax,ymin,ymax])
    hold off;
    exportgraphics(gcf, '../web/images/barchart.png', 'Resolution', 130, 'BackgroundColor', '#FDFDFD');
end