function doHigherSatisfiedRateOurAlgorithm()
    outputDir = "./out"; % 輸出檔放置的資料夾
   
    % 載入環境參數
    [ue_size, rangeOfPosition, r_UAVBS, minDataTransferRateOfUEAcceptable, maxDataTransferRateOfUAVBS, config] = loadEnvironment();
    

    % 確保輸出的資料夾存在
    % checkOutputDir(outputDir);
    data = zeros(1, 11);
    for times = 1:10
        % 生成UE及寫檔
        locationOfUEs = UE_generator(ue_size, rangeOfPosition);
        locationOfUEs = locationOfUEs(:,1:2);
        % save(outputDir+"/locationOfUEs.mat", "locationOfUEs");

        % 讀檔讀取UE
        % locationOfUEs = load(outputDir+"/locationOfUEs_6.mat").locationOfUEs;
        for i = 1:5
            maxDataTransferRateOfUAVBS = i*10^8;
            % minDataTransferRateOfUEAcceptable = (i*0.1)*10^6;
            % 演算法
            [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = ourAlgorithm(locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            
            UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
            indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]

        
            % 效能分析
            [totalDataTransferRatesOfUAVBSs, dataTransferRates, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            data(1,i+1)=data(1,i+1)+satisfiedRate;
        end

        % satisfiedRate
        % fairness

        % 繪圖
        % exportImage(outputDir+'/ourAlgorithm_higherSatisfiedRate.jpg', locationOfUEs, UAVBSsSet, UAVBSsR, indexArrayOfUEsServedByUAVBS, config);
    end
    data
end