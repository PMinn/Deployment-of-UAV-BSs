function SINR = signalToInterferencePlusNoiseRatio(locationOfUEs, UAVBSsRange, arrayOfAveragePathLoss) % arrayOfAveragePathLoss
    % SINR: SINR {[] []}
    % arrayOfAveragePathLoss: 無人機j到使用者u間的平均路徑損失 {[] []}
    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 100; % 功率
    
    % init
    arrayOfAveragePathLoss = UAVBSsRange;
    for i=1:size(arrayOfAveragePathLoss, 2)
        arrayOfAveragePathLoss{i} = zeros(size(arrayOfAveragePathLoss{i}, 1));
        for j=1:size(arrayOfAveragePathLoss{i}, 1)
            arrayOfAveragePathLoss{i}(j,1) = rand()*10^-5;
        end
    end
    UAVBSsRange
    
    % 計算無人機範圍內的使用者數量
    numOfUAVBSIncludingUE = zeros(size(UAVBSsRange, 2), 1); % [UAV1; UAV2; UAV3;...]
    for i=1:size(UAVBSsRange, 2)
        numOfUAVBSIncludingUE(i,1) = size(UAVBSsRange{i},1);
    end

    % 將每位使用者分配給一台無人機服務
    indexArrayOfUEsServedByUAVBS = zeros(size(locationOfUEs, 1), 1);
    for i=1:size(locationOfUEs, 1)
        minNumOfUAVBSIncludingUE = size(locationOfUEs, 1);
        for j=1:size(numOfUAVBSIncludingUE, 1)
            Lia = ismember(UAVBSsRange{j}, locationOfUEs(i,:),'rows');
            if nnz(Lia) && numOfUAVBSIncludingUE(j,1) < minNumOfUAVBSIncludingUE
                minNumOfUAVBSIncludingUE = numOfUAVBSIncludingUE(j,1);
                indexArrayOfUEsServedByUAVBS(i,1) = j;
            end
        end
    end
    indexArrayOfUEsServedByUAVBS

    % SINR的分子
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
            indexOfUEInLocationOfUEs = find(ismember(locationOfUEs, UAVBSsRange{i}(j,:),'rows')); % UEj在locationOfUEs的索引值
            if indexArrayOfUEsServedByUAVBS(indexOfUEInLocationOfUEs,1) == i % UEj是連線到UAVBSi
                arrayOfSignalToInterference(indexOfUEInLocationOfUEs,1) = arrayOfSignalToInterference(indexOfUEInLocationOfUEs,1)+signal{i}(j,1);
            else
                arrayOfSignalToInterference(indexOfUEInLocationOfUEs,2) = arrayOfSignalToInterference(indexOfUEInLocationOfUEs,2)+signal{i}(j,1);
            end
        end
    end
    arrayOfSignalToInterference
    % signal

    % SINR的分子
    % numeratorOfSINR 
    % SINR的分母
    % denominatorOfSINR = arrayOfAveragePathLoss;

    SINR = {};
end