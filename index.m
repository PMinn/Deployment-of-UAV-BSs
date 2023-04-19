
function index()
    % 參數
    outputDir = "./out";
    ue_size = 50;
    r_UABBS = 40;
    % 變數

    checkOutputDir(outputDir);
    locationOfUEs = UE_generator(ue_size);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs")

    xArrayFromlocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromlocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列
    
    boundaryUEsSet = boundary(xArrayFromlocationOfUEs, yArrayFromlocationOfUEs, 0.1); % 邊界上的UE集合

    [UAVBSsSet] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UABBS)
    % boundaryUEsSet2 = findBoundaryUEsSet(uncoveredUEsSet)
    % [u, Pprio] = localCover(r_UABBS, boundaryUEsSet2(1,:), Pprio, Psec)

    % 繪圖
    hold on;
    scatter(xArrayFromlocationOfUEs, yArrayFromlocationOfUEs, 20, "filled", "^", "b"); % 畫出所有UE
    plot(xArrayFromlocationOfUEs(boundaryUEsSet), yArrayFromlocationOfUEs(boundaryUEsSet), "--"); % 畫出邊界線
    
    scatter(UAVBSsSet(:,1), UAVBSsSet(:,2), 20, "filled", "square", "k"); % 畫出所有UAVBS
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        rectangle('Position',[x-r_UABBS,y-r_UABBS,2*r_UABBS,2*r_UABBS],'Curvature',[1,1],'EdgeColor','m');
    end
    hold off;
end