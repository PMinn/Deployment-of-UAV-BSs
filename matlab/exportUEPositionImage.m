function exportUEPositionImage(locationOfUEs, r_UAVBS)
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
    xArrayFromLocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromLocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列

    scatter(xArrayFromLocationOfUEs, yArrayFromLocationOfUEs, 20, "filled", "^", 'MarkerEdgeColor', UEColor, 'MarkerFaceColor', UEColor); % 所有UEs的點
    axis equal;
    minPosition = min(locationOfUEs);
    maxPosition = max(locationOfUEs);
    axis([minPosition(1,1)-r_UAVBS maxPosition(1,1)+r_UAVBS minPosition(1,2)-r_UAVBS maxPosition(1,2)+r_UAVBS]); % axis([xmin,xmax,ymin,ymax])
    hold off;
    exportgraphics(gcf, '../web/images/UE.jpg', 'Resolution', 130, 'BackgroundColor', backgroundColor);
end