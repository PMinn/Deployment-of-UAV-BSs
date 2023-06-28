function doKmeans()
    outputDir = "./out"; % 輸出檔放置的資料夾
   
    % 載入環境參數
    [ue_size, rangeOfPosition, r_UAVBS, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS, config] = loadEnvironment();
    

    k = 30; % kmeans的k值 12 60

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 
    
    % 生成UE及寫檔
    % locationOfUEs = UE_generator(ue_size, rangeOfPosition);
    % locationOfUEs = locationOfUEs(:,1:2);
    % save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

    % 讀檔讀取UE
    locationOfUEs = load(outputDir+"/locationOfUEs_5.mat").locationOfUEs;

    % 演算法
    [indexArrayOfUEsServedByUAVBS, UAVBSsSet] = kmeans(locationOfUEs ,k);
    UAVBSsR = zeros(k, 1);
    for i = 1:k
        [indexOfUEs] = find(indexArrayOfUEsServedByUAVBS == i);
        UAVBSsR(i,1) = max(pdist2(locationOfUEs(indexOfUEs, :), UAVBSsSet(i, :)));
    end

    UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
    
    % 效能分析
    [totalDataTransferRatesOfUAVBSs, dataTransferRates, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config, true);
    satisfiedRate
    fairness

    % 繪圖
    exportImage(outputDir+'/kmeans.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);

    % JOSN
    % json = exportJSON(locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);
    % fileID = fopen(outputDir+'/data.json','w');
    % fprintf(fileID, '%s', json);
    % fclose(fileID);
end