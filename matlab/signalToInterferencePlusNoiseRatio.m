function SINR = signalToInterferencePlusNoiseRatio(locationOfUEs, UAVBSsRange, arrayOfAveragePathLoss) % arrayOfAveragePathLoss
    % SINR: SINR {[] []}
    % arrayOfAveragePathLoss: 無人機j到使用者u間的平均路徑損失 {[] []}
    bandwidth = 2*10^7; % 頻寬
    powerOfUAVBS = 100; % 功率
    
    % 計算無人機範圍內的使用者數量
    numOfUAVBSIncludingUE = zeros(size(UAVBSsRange, 2), 1); % [a;b;c]
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

    % SINR的分子
    signal = arrayOfAveragePathLoss;
    for i=1:size(signal, 2)
        for j=1:size(signal{i},1)
            signal{i}(j,1) = powerOfUAVBS*(10^(-1*signal{i}(j,1)/10));
        end
    end



    % SINR的分子
    % numeratorOfSINR 
    % SINR的分母
    % denominatorOfSINR = arrayOfAveragePathLoss;

    SINR = {};
end