function exportImage(file, locationOfUEs, UAVBSsSet, UAVBSsR)
    backgroundColor = '#FDFDFD';
    UAVBSColor = '#61Cd81';
    UEColor = '#2F71F4';
    boundaryColor = '#242424';
    textColor = '#242424';
    connectLineColor = '#DE5137';
    clf(gcf);
    set(gcf,'outerposition', get(0,'screensize')); % 視窗最大
    set(gcf,'visible', 'off');
    set(gca, 'Color', backgroundColor);
    hold on;
    boundaryUEsSet = convhull(locationOfUEs); % 凸包上的UE集合
    xArrayFromLocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromLocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列
    plot(xArrayFromLocationOfUEs(boundaryUEsSet), yArrayFromLocationOfUEs(boundaryUEsSet), 'Color', boundaryColor, 'LineStyle', "--"); % 邊界線

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
        line(x, y, 'Color', connectLineColor, 'Linestyle', '-');
    end


    % UAVBSs的範圍
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        rectangle('Position', [x-UAVBSsR(i,1),y-UAVBSsR(i,1),2*UAVBSsR(i,1),2*UAVBSsR(i,1)], 'Curvature', [1,1], 'EdgeColor', UAVBSColor, 'LineWidth', 1);
    end
    scatter(UAVBSsSet(:,1), UAVBSsSet(:,2), 80, "filled", "square", 'MarkerFaceColor', UAVBSColor); % 所有UAVBSs的點
    scatter(xArrayFromLocationOfUEs, yArrayFromLocationOfUEs, 20, "filled", "^", 'MarkerEdgeColor', UEColor, 'MarkerFaceColor', UEColor); % 所有UEs的點
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        text(x, y, string(i)+' ', 'HorizontalAlignment', 'right', 'FontSize', 14, 'FontWeight', 'bold', 'Color', textColor);
    end
    axis equal;
    minPosition = min(locationOfUEs);
    maxPosition = max(locationOfUEs);
    maxR = max(UAVBSsR);
    axis([minPosition(1,1)-maxR maxPosition(1,1)+maxR minPosition(1,2)-maxR maxPosition(1,2)+maxR]); % axis([xmin,xmax,ymin,ymax])
    hold off;
    exportgraphics(gcf, file, 'Resolution', 130, 'BackgroundColor', backgroundColor);
end