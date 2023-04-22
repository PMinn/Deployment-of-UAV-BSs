function UAVBSsSet = index(ue_size, rangeOfPositionMin, rangeOfPositionMax, r_UAVBS, isCounterClockwise, startAngleOfSpiral)
    rangeOfPosition = [rangeOfPositionMin rangeOfPositionMax]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    % ue_size = 100; % 生成UE的數量
    % rangeOfPosition = [0 200]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    % r_UAVBS = 30; % UAVBS涵蓋的範圍
    % isCounterClockwise = false; % true=逆時針; false=順時針
    % startAngleOfSpiral = 90; % 旋轉排序的起始角度(0~360deg)

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    

    % 生成UE及寫檔
    locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    % locationOfUEs = load(outputDir+"/locationOfUEs.mat").locationOfUEs;


    % 演算法
    [UAVBSsSet, UAVBSsRange] = spiralMBSPlacementAlgorithm(isCounterClockwise, locationOfUEs, r_UAVBS, startAngleOfSpiral);


    % 繪圖
    set(gcf,'outerposition',get(0,'screensize')); % 視窗最大
    hold on;
    boundaryUEsSet = convhull(locationOfUEs); % 凸包上的UE集合
    xArrayFromLocationOfUEs = locationOfUEs(:,1); % UE的x座標陣列
    yArrayFromLocationOfUEs = locationOfUEs(:,2); % UE的y座標陣列
    plot(xArrayFromLocationOfUEs(boundaryUEsSet), yArrayFromLocationOfUEs(boundaryUEsSet), 'color', 'k', 'linestyle', "--"); % 邊界線

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
        line(x, y, 'color', 'r', 'linestyle', '-');
    end


    % UAVBSs的範圍
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        rectangle('Position', [x-r_UAVBS,y-r_UAVBS,2*r_UAVBS,2*r_UAVBS], 'Curvature', [1,1], 'EdgeColor', 'g');
    end
    scatter(UAVBSsSet(:,1), UAVBSsSet(:,2), 80, "filled", "square", "g"); % 所有UAVBSs的點
    scatter(xArrayFromLocationOfUEs, yArrayFromLocationOfUEs, 20, "^", "b"); % 所有UEs的點
    for i=1:size(UAVBSsSet,1)
        x = UAVBSsSet(i,1);
        y = UAVBSsSet(i,2);
        text(x, y, string(i)+' ', 'HorizontalAlignment', 'right', 'FontSize', 14, 'FontWeight', 'bold'); % +' \rightarrow '
    end
    axis equal;
    hold off;
    set(gcf,'visible','off');
    exportgraphics(gcf, outputDir+'/barchart.png', 'Resolution', 300);
    clf(gcf);
end