function [totalDataTransferRatesOfUAVBSs, satisfiedRate, dataTransferRates] = main(ue_size, rangeOfPosition, r_UAVBS, isCounterClockwise, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS)
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    % ue_size = 100; % 生成UE的數量
    % rangeOfPosition = 400; % UE座標的範圍
    % r_UAVBS = 30; % UAVBS涵蓋的範圍
    % isCounterClockwise = false; % true=逆時針; false=順時針
    % minDataTransferRateOfUEAcceptable: 使用者可接受的最低速率
    % maxDataTransferRateOfUAVBS: 無人機回程速率上限
    startAngleOfSpiral = 90; % 旋轉排序的起始角度(0~360deg)
    
    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 0.1; % 功率
    noise = 4.1843795*10^-21; % 熱雜訊功率譜密度
    a = 12.08; % 環境變數
    b = 0.11; % 環境變數
    frequency = 2*10^9; % 行動通訊的載波頻寬(Hz)
    constant = 3*10^8; % 光的移動速率(m/s)
    etaLos = 1.6; % Los的平均訊號損失
    etaNLos = 23; % NLos的平均訊號損失
    
    config = dictionary(["bandwidth" "powerOfUAVBS" "noise"           "a"   "b"  "frequency" "constant" "etaLos" "etaNLos" "minHeight" "maxHeight" "minR"              "maxR"              ] ...
                       ,[2*10^7      0.1            4.1843795*10^-21  12.08 0.11 2*10^9      3*10^8     1.6      23        30          120         getAreaByHeight(30) getAreaByHeight(120)]);
    % bandwidth 頻寬
    % powerOfUAVBS 功率
    % noise 熱雜訊功率譜密度
    % a 環境變數
    % b 環境變數
    % frequency 行動通訊的載波頻寬(Hz)
    % constant 光的移動速率(m/s)
    % etaLos Los的平均訊號損失
    % etaNLos NLos的平均訊號損失
    % minHeight 法定最高高度
    % maxHeight 法定最高高度

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    % 生成UE及寫檔
    locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    % locationOfUEs = load(outputDir+"/locationOfUEs.mat").locationOfUEs;

    % 演算法
    [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = ourAlgorithm(locationOfUEs, minDataTransferRateOfUEAcceptable, config);
    
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]

    % 效能分析
    [totalDataTransferRatesOfUAVBSs,dataTransferRates,satisfiedRate,fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);

    % 繪圖
    exportImage('../web/images/barchart.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);
end