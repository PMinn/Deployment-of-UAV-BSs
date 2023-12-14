function data = emulator(ue_size, rangeOfPosition, r_UAVBS, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS)
    outputDir = "../static";

    % 載入環境參數
    [~, ~, ~, ~, ~, config] = loadEnvironment();

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    % 生成UE及寫檔
    locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    locationOfUEs = locationOfUEs(:,1:2);

    satisfiedRateData = zeros(1, 6);
    fairnessData = zeros(1, 6);
    dataRate = zeros(1, 6);
    numberOfUAVBS = zeros(1, 6);
    energyEfficiency = zeros(1, 6);

    % 演算法
    [UAVBSsSet, ~] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UAVBS);
    UAVBSsR = zeros(size(UAVBSsSet,1),1); % UAVBSs的半徑
    for i=1:size(UAVBSsR,1)
        UAVBSsR(i,1) = r_UAVBS;
    end
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UEsPositionOfUAVBSIncluded, locationOfUEs, UAVBSsSet); % 每位使用者連線到的無人機 [n1; n2;...]
    % 效能分析
    [totalDataTransferRatesOfUAVBSs, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRateData(1,1) = satisfiedRate;
    fairnessData(1,1) = fairness;
    tempDataRate = sum(totalDataTransferRatesOfUAVBSs, "all");
    dataRate(1,1) = tempDataRate;
    k1 = size(UAVBSsSet,1);
    numberOfUAVBS(1,1) = k1;
    energyEfficiency(1,1) = tempDataRate / k1;
    % 繪圖
    exportImage(outputDir+'/spiralMBSPlacementAlgorithm.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, UEsPositionOfUAVBSIncluded, config);

    % 演算法
    [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = ourAlgorithm(locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]
    % 效能分析
    [totalDataTransferRatesOfUAVBSs, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRateData(1,  2) = satisfiedRate;
    fairnessData(1,  2) = fairness;
    tempDataRate = sum(totalDataTransferRatesOfUAVBSs, "all");
    dataRate(1, 2) = tempDataRate;
    k2 = size(UAVBSsSet,1);
    numberOfUAVBS(1, 2) =  k2;
    energyEfficiency(1, 2) = (tempDataRate / k2);
    % 繪圖
    exportImage(outputDir+'/ourAlgorithm.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, UEsPositionOfUAVBSIncluded, config);

    % 演算法
    [indexArrayOfUEsServedByUAVBS, UAVBSsSet] = kmeans(locationOfUEs ,k1);
    UAVBSsR = zeros(k1, 1);
    for i = 1:k1
        [indexOfUEs] = find(indexArrayOfUEsServedByUAVBS == i);
        r = pdist2(locationOfUEs(indexOfUEs, :), UAVBSsSet(i, :));
        UAVBSsR(i,1) = max([r;config("minR")], [], "all");
        UAVBSsR(i,1) = min([UAVBSsR(i,1);config("maxR")], [], "all");
    end
    % 效能分析
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet);
    [totalDataTransferRatesOfUAVBSs, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRateData(1, 3) = satisfiedRate;
    fairnessData(1, 3) =  fairness;
    tempDataRate = sum(totalDataTransferRatesOfUAVBSs, "all");
    dataRate(1, 3) = tempDataRate;
    numberOfUAVBS(1, 3) = k1;
    energyEfficiency(1, 3) = (tempDataRate / k1);
    % 繪圖
    exportImage(outputDir+'/kmeans_sMBSP', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);

    % 演算法
    [indexArrayOfUEsServedByUAVBS, UAVBSsSet] = kmeans(locationOfUEs ,k2);
    UAVBSsR = zeros(k2, 1);
    for i = 1:k2
        [indexOfUEs] = find(indexArrayOfUEsServedByUAVBS == i);
        r = pdist2(locationOfUEs(indexOfUEs, :), UAVBSsSet(i, :));
        UAVBSsR(i,1) = max([r;config("minR")], [], "all");
        UAVBSsR(i,1) = min([UAVBSsR(i,1);config("maxR")], [], "all");
    end
    % 效能分析
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet);
    [totalDataTransferRatesOfUAVBSs, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRateData(1, 4) = satisfiedRate;
    fairnessData(1, 4) = fairness;
    tempDataRate = sum(totalDataTransferRatesOfUAVBSs, "all");
    dataRate(1, 4) = tempDataRate;
    numberOfUAVBS(1, 4) = k2;
    energyEfficiency(1, 4) =  (tempDataRate / k2);
    % 繪圖
    exportImage(outputDir+'/kmeans_our', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);
    
    % 演算法
    [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = randomAlgorithm(locationOfUEs, rangeOfPosition, config);
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]
    % 效能分析
    [totalDataTransferRatesOfUAVBSs, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRateData(1, 5) =  satisfiedRate;
    fairnessData(1, 5) =fairness;
    tempDataRate = sum(totalDataTransferRatesOfUAVBSs, "all");
    dataRate(1, 5) = tempDataRate;
    tempNumberOfUAVBS = size(UAVBSsSet,1);
    numberOfUAVBS(1, 5) =  tempNumberOfUAVBS;
    energyEfficiency(1, 5) =  (tempDataRate / tempNumberOfUAVBS);
    % 繪圖
    exportImage(outputDir + '/randomAlgorithm', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);

    % 演算法
    [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = voronoiAlgorithm(locationOfUEs, r_UAVBS, config);
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]
    % 效能分析
    [totalDataTransferRatesOfUAVBSs, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRateData(1, 6) = satisfiedRate;
    fairnessData(1, 6) = fairness;
    tempDataRate = sum(totalDataTransferRatesOfUAVBSs, "all");
    dataRate(1, 6) = tempDataRate;
    tempNumberOfUAVBS = size(UAVBSsSet,1);
    numberOfUAVBS(1, 6) =  tempNumberOfUAVBS;
    energyEfficiency(1, 6) =(tempDataRate / tempNumberOfUAVBS);
    % 繪圖
    exportImage(outputDir + '/voronoi', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);

    keys = ["satisfiedRateData"; "fairnessData"; "dataRate"; "numberOfUAVBS"; "energyEfficiency"];
    values = {satisfiedRateData; fairnessData; dataRate; numberOfUAVBS; energyEfficiency};
    map = containers.Map(keys, values);
    data = jsonencode(map);
end