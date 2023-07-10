function doCompareCmin()
    outputDir = "./out"; % 輸出檔放置的資料夾
    
    % 載入環境參數
    [~, rangeOfPosition, r_UAVBS, ~, maxDataTransferRateOfUAVBS, config] = loadEnvironment();
    ue_size = 800;

    % 確保輸出的資料夾存在
    checkOutputDir(outputDir); 

    satisfiedRateData = zeros(6, 4);
    fairnessData = zeros(6, 4);

    for times = 1:100
        for index = 1:6
            disp(string(index)+"/6");

            % 生成UE及寫檔
            locationOfUEs = UE_generator(ue_size, rangeOfPosition);
            locationOfUEs = locationOfUEs(:,1:2);
            % save(outputDir+"/locationOfUEs_Cmin"+string(ue_size)+".mat", "locationOfUEs");

            % 讀檔讀取UE
            % locationOfUEs = load(outputDir+"/locationOfUEs_5.mat").locationOfUEs;

            minDataTransferRateOfUEAcceptable = index*10^6;
        
            % 演算法
            [UAVBSsSet, ~] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UAVBS);
            UAVBSsR = zeros(size(UAVBSsSet,1),1); % UAVBSs的半徑
            for i=1:size(UAVBSsR,1)
                UAVBSsR(i,1) = r_UAVBS;
            end
            UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
            indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UEsPositionOfUAVBSIncluded, locationOfUEs, UAVBSsSet); % 每位使用者連線到的無人機 [n1; n2;...]
            % 效能分析
            [~, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            satisfiedRateData(index, 1) = satisfiedRateData(index, 1)+satisfiedRate;
            fairnessData(index, 1) = fairnessData(index, 1)+fairness;
            k1 = size(UAVBSsSet,1);
            
            % 演算法
            [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = ourAlgorithm(locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet); % 該UAVBS涵蓋住的所有UE座標(包含連線與未連線)
            indexArrayOfUEsServedByUAVBS = includedPositionToIndex(UEsPositionOfUAVServedBy, locationOfUEs); % 每位使用者連線到的無人機 [n1; n2;...]
            % 效能分析
            [~, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            satisfiedRateData(index, 2) = satisfiedRateData(index, 2)+satisfiedRate;
            fairnessData(index, 2) = fairnessData(index, 2)+fairness;
            k2 = size(UAVBSsSet,1);

            % 演算法
            [indexArrayOfUEsServedByUAVBS, UAVBSsSet] = kmeans(locationOfUEs ,k1);
            UAVBSsR = zeros(k1, 1);
            for i = 1:k1
                [indexOfUEs] = find(indexArrayOfUEsServedByUAVBS == i);
                UAVBSsR(i,1) = max([pdist2(locationOfUEs(indexOfUEs, :), UAVBSsSet(i, :));30]);
            end
            % 效能分析
            UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet);
            [~, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            satisfiedRateData(index, 3) = satisfiedRateData(index, 3)+satisfiedRate;
            fairnessData(index, 3) = fairnessData(index, 3)+fairness;

            % 演算法
            [indexArrayOfUEsServedByUAVBS, UAVBSsSet] = kmeans(locationOfUEs ,k2);
            UAVBSsR = zeros(k2, 1);
            for i = 1:k2
                [indexOfUEs] = find(indexArrayOfUEsServedByUAVBS == i);
                UAVBSsR(i,1) = max([pdist2(locationOfUEs(indexOfUEs, :), UAVBSsSet(i, :));30]);
            end
            % 效能分析
            UEsPositionOfUAVBSIncluded = getUEsPositionOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet);
            [~, ~, satisfiedRate, fairness] = performance(indexArrayOfUEsServedByUAVBS, UAVBSsSet, UEsPositionOfUAVBSIncluded, UAVBSsR, locationOfUEs, maxDataTransferRateOfUAVBS, minDataTransferRateOfUEAcceptable, config);
            satisfiedRateData(index, 4) = satisfiedRateData(index, 4)+satisfiedRate;
            fairnessData(index, 4) = fairnessData(index, 4)+fairness;
        end
        save(outputDir+"/satisfiedRateData_varyingCmin_100times.mat", "satisfiedRateData");
        save(outputDir+"/fairnessData_varyingCmin_100times.mat", "fairnessData");
        disp(string(times)+'/100');
    end
    satisfiedRateData
end