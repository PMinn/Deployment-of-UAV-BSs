function doSpiralMBSPlacementAlgorithm()
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    ue_size = 500; % 生成UE的數量
    rangeOfPosition = [0 400]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    r_UAVBS = 80; % UAVBS涵蓋的範圍
    isCounterClockwise = false; % true=逆時針; false=順時針
    startAngleOfSpiral = 90; % 旋轉排序的起始角度(0~360deg)
    minDataTransferRateOfUEAcceptable = 5*10^6; % 使用者可接受的最低速率
    maxDataTransferRateOfUAVBS = 1.5*10^8; % 無人機回程速率上限

    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 0.1; % 功率
    noise = 4.1843795*10^-21; % 熱雜訊功率譜密度
    a = 12.08; % 環境變數
    b = 0.11; % 環境變數
    frequency = 2*10^9; % 行動通訊的載波頻寬(Hz)
    constant = 3*10^8; % 光的移動速率(m/s)
    etaLos = 1.6; % Los的平均訊號損失
    etaNLos = 23; % NLos的平均訊號損失

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    
    % 生成UE及寫檔
    locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    % locationOfUEs = load(outputDir+"/locationOfUEs.mat").locationOfUEs;

    % 演算法
    [UAVBSsSet, UEsPositionOfUAVBSIncluded] = spiralMBSPlacementAlgorithm(isCounterClockwise, locationOfUEs, r_UAVBS, startAngleOfSpiral);
    % UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(r_UAVBS, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋的UE座標

    UAVBSsR = zeros(size(UAVBSsSet,1),1); % UAVBSs的半徑
    for i=1:size(UAVBSsR,1)
        UAVBSsR(i,1) = r_UAVBS;
    end
    indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UEsPositionOfUAVBSIncluded, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]

    % 效能分析
    [totalDataTransferRatesOfUAVBSs,dataTransferRates,satisfiedRate,fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, a, b, UAVBSsR, frequency, constant, etaLos, etaNLos, locationOfUEs, powerOfUAVBS, noise, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, bandwidth);
    satisfiedRate
    fairness

    % 繪圖
    exportImage(outputDir+'/spiralMBSPlacementAlgorithm.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, UEsPositionOfUAVBSIncluded);
end