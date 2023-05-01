function SINR = signalToInterferencePlusNoiseRatio(locationOfUEs, UEsPositionOfUAVBSIncluded, arrayOfAveragePathLoss, indexArrayOfUEsServedByUAVBS, arrayOfBandwidths, powerOfUAVBS, noise)
    % SINR: 每個UE的SINR []
    % UEsPositionOfUAVBSIncluded: UAVBS涵蓋的UE座標 {[] []}
    % arrayOfAveragePathLoss: 無人機j到使用者u間的平均路徑損失 {[] []}
    % indexArrayOfUEsServedByUAVBS: 每位使用者連線到的無人機 [n1; n2;...]
    % arrayOfBandwidths: 無人機平均每個UE分到的頻寬
    % powerOfUAVBS: 功率
    % noise: 熱雜訊功率譜密度

    % init
    arrayOfAveragePathLoss = UEsPositionOfUAVBSIncluded;
    for i=1:size(arrayOfAveragePathLoss, 2)
        arrayOfAveragePathLoss{i} = zeros(size(arrayOfAveragePathLoss{i}, 1));
        for j=1:size(arrayOfAveragePathLoss{i}, 1)
            arrayOfAveragePathLoss{i}(j,1) = rand()*10^1;
        end
    end

    % 計算所有signal
    signal = arrayOfAveragePathLoss;
    for i=1:size(signal, 2)
        for j=1:size(signal{i},1)
            signal{i}(j,1) = powerOfUAVBS*(10^(-1*signal{i}(j,1)/10));
        end
    end

    % signalToInterference
    arrayOfSignalToInterference = zeros(size(locationOfUEs,1),2);
    for i=1:size(signal, 2)
        for j=1:size(signal{i},1)
            index_of_UE_in_locationOfUEs = find(ismember(locationOfUEs, UEsPositionOfUAVBSIncluded{i}(j,:),'rows')); % UEj在locationOfUEs的索引值
            if indexArrayOfUEsServedByUAVBS(index_of_UE_in_locationOfUEs,1) == i % UEj是連線到UAVBSi
                arrayOfSignalToInterference(index_of_UE_in_locationOfUEs,1) = arrayOfSignalToInterference(index_of_UE_in_locationOfUEs,1)+signal{i}(j,1);
            else
                arrayOfSignalToInterference(index_of_UE_in_locationOfUEs,2) = arrayOfSignalToInterference(index_of_UE_in_locationOfUEs,2)+signal{i}(j,1);
            end
        end
    end
    
    % arrayOfSignalToInterference + noise
    % 2023/5/1 這裡有點問題 (arrayOfBandwidths(indexArrayOfUEsServedByUAVBS(i,1),1)*noise) 太小 往上乘SINR太大 速率也會很大
    for i=1:size(arrayOfSignalToInterference,1)
        arrayOfSignalToInterference(i,2) = arrayOfSignalToInterference(i,2)+(arrayOfBandwidths(indexArrayOfUEsServedByUAVBS(i,1),1)*noise);
    end
    
    SINR = zeros(size(arrayOfSignalToInterference,1),1);
    for i=1:size(SINR,1)
        SINR(i,1) = arrayOfSignalToInterference(i,1)/arrayOfSignalToInterference(i,2);
    end
end