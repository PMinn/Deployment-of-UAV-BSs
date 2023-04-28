function test()
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    ue_size = 100; % 生成UE的數量
    rangeOfPosition = [0 200]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    r_UAVBS = 30; % UAVBS涵蓋的範圍
    isCounterClockwise = false; % true=逆時針; false=順時針
    startAngleOfSpiral = 90; % 旋轉排序的起始角度(0~360deg)

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
    UAVBSsRange
    % 繪圖
    exportImage(outputDir+'/test.jpg', locationOfUEs, UAVBSsSet, r_UAVBS);
end