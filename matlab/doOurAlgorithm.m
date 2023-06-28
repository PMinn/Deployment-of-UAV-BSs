function doOurAlgorithm()
    outputDir = "./out"; % 輸出檔放置的資料夾
   
    % 載入環境參數
    [ue_size, rangeOfPosition, r_UAVBS, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS, config] = loadEnvironment();
    

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    
    % 生成UE及寫檔
    % locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    % locationOfUEs = locationOfUEs(:,1:2);
    % save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    locationOfUEs = load(outputDir+"/locationOfUEs_5.mat").locationOfUEs;

    % 演算法
    [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = ourAlgorithm(locationOfUEs, minDataTransferRateOfUEAcceptable, config);
    
    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]

    % 效能分析
    [totalDataTransferRatesOfUAVBSs, dataTransferRates, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
    satisfiedRate
    fairness

    % 繪圖
    exportImage(outputDir+'/ourAlgorithm.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);

    % JOSN
    json = exportJSON(locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);
    fileID = fopen(outputDir+'/data.json','w');
    fprintf(fileID, '%s', json);
    fclose(fileID);
end