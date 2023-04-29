function test()
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    ue_size = 100; % 生成UE的數量
    rangeOfPosition = [0 200]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    r_UAVBS = 30; % UAVBS涵蓋的範圍
    isCounterClockwise = false; % true=逆時針; false=順時針
    startAngleOfSpiral = 90; % 旋轉排序的起始角度(0~360deg)

    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 100; % 功率
    noise = 4.1843795*10^-21; % 熱雜訊功率譜密度

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    

    % 生成UE及寫檔
    % locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    % locationOfUEs = locationOfUEs(:,1:2);
    % save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    locationOfUEs = load(outputDir+"/locationOfUEs.mat").locationOfUEs;

    % 演算法
    UAVBSsSet = spiralMBSPlacementAlgorithm(isCounterClockwise, locationOfUEs, r_UAVBS, startAngleOfSpiral);
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(r_UAVBS, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋的UE座標

    % 效能分析
    indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UEsPositionOfUAVBSIncluded, locationOfUEs); % 每位使用者連線到的無人機
    SINR = signalToInterferencePlusNoiseRatio(locationOfUEs, UEsPositionOfUAVBSIncluded, {}, indexArrayOfUEsServedByUAVBS, bandwidth, powerOfUAVBS, noise);
    dataTransferRates = getDataTransferRate(SINR, bandwidth);
    totalDataTransferRatesOfUAVBSs = getTotalDataTransferRatesOfUAVBSs(dataTransferRates, indexArrayOfUEsServedByUAVBS);

    % 繪圖
    exportImage(outputDir+'/test.jpg', locationOfUEs, UAVBSsSet, r_UAVBS);
end