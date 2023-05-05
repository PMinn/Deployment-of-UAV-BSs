function doOurAlgorithm()
    % 參數
    outputDir = "./out"; % 輸出檔放置的資料夾
    ue_size = 500; % 生成UE的數量
    rangeOfPosition = [0 200]; % UE座標的範圍 X介於[a b] Y介於[a b] 
    r_UAVBS = 30; % UAVBS涵蓋的範圍
    

    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 100*10^-7; % 功率(W)
    noise = 4.1843795*10^-21; % 熱雜訊功率譜密度
    minHeight = 30; % 法定最高高度
    maxHeight = 120; % 法定最高高度

    minDataTransferRateOfUEAcceptable = 10^6; % 使用者可接受的最低速率
    maxDataTransferRateOfUAVBS = 1.5*10^8; % 無人機回程速率上限

    maxNumOfUE = bandwidth/minDataTransferRateOfUEAcceptable; % 無人機符合滿意度之下，能服務的最大UE數量

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    

    % 生成UE及寫檔
    locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    locationOfUEs = locationOfUEs(:,1:2);
    save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    % locationOfUEs = load(outputDir+"/locationOfUEs.mat").locationOfUEs;


    % 演算法
    [UAVBSsSet, UAVBSsR] = ourAlgorithm(minHeight, maxHeight, maxNumOfUE, locationOfUEs);

    % 繪圖
    exportImage(outputDir+'/test.jpg', locationOfUEs, UAVBSsSet, UAVBSsR);
end