
function index()
    % 參數
    outputDir = "./out";
    ue_size = 200;
    r_UABBS = 30;
    % 變數

    checkOutputDir(outputDir);
    locationOfUEs = UE_generator(ue_size);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs")

    xArrayFromlocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromlocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列
    
    boundaryUEsSet = boundary(xArrayFromlocationOfUEs, yArrayFromlocationOfUEs, 0.1); % 邊界上的UE集合

    [UAVBSsSet, UAVBSsRange] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UABBS)

    % 繪圖
    hold on;
    scatter(xArrayFromlocationOfUEs, yArrayFromlocationOfUEs, 20, "filled", "^", "b"); % 所有UEs的點
    for i=1:size(UAVBSsRange,2)
        % scatter(UAVBSsRange{i}(:,1), UAVBSsRange{i}(:,2), 20, "filled", "^"); % UAVBS涵蓋的UEs的點
        % UEs所屬的UAVBS
        % for j=1:size(UAVBSsRange{1,i},1)
        %     text(UAVBSsRange{1,i}(j,1), UAVBSsRange{1,i}(j,2),'\leftarrow ' + string(i));
        % end
    end
    plot(xArrayFromlocationOfUEs(boundaryUEsSet), yArrayFromlocationOfUEs(boundaryUEsSet), "--"); % 邊界線
    
    scatter(UAVBSsSet(:,1), UAVBSsSet(:,2), 20, "filled", "square", "k"); % 所有UAVBSs的點
    % UAVBSs的範圍
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        rectangle('Position',[x-r_UABBS,y-r_UABBS,2*r_UABBS,2*r_UABBS],'Curvature',[1,1],'EdgeColor','m');
        text(x,y,'UAVBS '+string(i)+' \rightarrow ','HorizontalAlignment','right');
    end
    axis equal;
    hold off;
end