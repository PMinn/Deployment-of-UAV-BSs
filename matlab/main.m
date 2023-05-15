function [totalDataTransferRatesOfUAVBSs, satisfiedRate, dataTransferRates] = main(ue_size, rangeOfPosition, r_UAVBS, isCounterClockwise, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS)
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    % ue_size = 100; % 生成UE的數量
    % rangeOfPosition = [0 200]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    % r_UAVBS = 30; % UAVBS涵蓋的範圍
    % isCounterClockwise = false; % true=逆時針; false=順時針
    % minDataTransferRateOfUEAcceptable: 使用者可接受的最低速率
    % maxDataTransferRateOfUAVBS: 無人機回程速率上限
    startAngleOfSpiral = 90; % 旋轉排序的起始角度(0~360deg)
    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 100; % 功率
    noise = 4.1843795*10^-21; % 熱雜訊功率譜密度
    
    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    % 生成UE及寫檔
    locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    % locationOfUEs = load(outputDir+"/locationOfUEs.mat").locationOfUEs;

    % 演算法
    UAVBSsSet = spiralMBSPlacementAlgorithm(isCounterClockwise, locationOfUEs, r_UAVBS, startAngleOfSpiral);
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(r_UAVBS, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋的UE座標

    % 效能分析
    indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UEsPositionOfUAVBSIncluded, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]
    numOfUEsConnected = zeros(size(UAVBSsSet,1),1); % 每台UAVBS連線到的UE數量
    for i=1:size(numOfUEsConnected,1)
        numOfUEsConnected(i,1) = size(find(indexArrayOfUEsServedByUAVBS == i),1);
    end
    UEsLosOfPossibility = getLosOfPossibility(UAVBSsSet, UEsPositionOfUAVBSIncluded, r_UAVBS);
    UEsLos = getUAVandUEsLos(UAVBSsSet, UEsPositionOfUAVBSIncluded, UEsLosOfPossibility,r_UAVBS); % 平均路徑損失
    arrayOfBandwidths = getBandwidths(numOfUEsConnected, bandwidth);
    SINR = signalToInterferencePlusNoiseRatio(locationOfUEs, UEsPositionOfUAVBSIncluded, UEsLos, indexArrayOfUEsServedByUAVBS, arrayOfBandwidths, powerOfUAVBS, noise); % [SINR1; SINR2;...]
    dataTransferRates = getDataTransferRate(SINR, indexArrayOfUEsServedByUAVBS, arrayOfBandwidths); % [dataTransferRates1; dataTransferRates2;...]
    totalDataTransferRatesOfUAVBSs = getTotalDataTransferRatesOfUAVBSs(dataTransferRates, indexArrayOfUEsServedByUAVBS); % [totalDataTransferRatesOfUAVBSs1; totalDataTransferRatesOfUAVBSs2;...]
    % 往回檢查速率上限
    overflowIndex = find(totalDataTransferRatesOfUAVBSs > maxDataTransferRateOfUAVBS);
    totalDataTransferRatesOfUAVBSs(overflowIndex,1) = maxDataTransferRateOfUAVBS;
    for i=1:size(overflowIndex,1)
        indexOfUAVBS = overflowIndex(i,1);
        indexOfUEConnected = find(indexArrayOfUEsServedByUAVBS == indexOfUAVBS); % 該超過速率的UAV所連線到的UE
        numOfUE = size(indexOfUEConnected,1); % 連線到的UE數量
        newDataTransferRate = maxDataTransferRateOfUAVBS/numOfUE; % 重新分配後的速率
        dataTransferRates(indexOfUEConnected, 1) = newDataTransferRate;
    end
    indexOfSatisfied  = find(dataTransferRates > minDataTransferRateOfUEAcceptable); % 滿意的UE
    satisfiedRate = size(indexOfSatisfied,1)/size(dataTransferRates,1); % 滿意度

    % 繪圖
    exportImage('../web/images/barchart.jpg', locationOfUEs, UAVBSsSet, r_UAVBS);
end