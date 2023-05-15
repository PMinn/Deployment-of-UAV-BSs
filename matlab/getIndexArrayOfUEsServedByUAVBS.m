function indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UAVBSsRange, locationOfUEs)
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
end