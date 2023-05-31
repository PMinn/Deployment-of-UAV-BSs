function indexArrayOfUEsServedByUAVBS = getIndexArrayOfUEsServedByUAVBS(UEsPositionOfUAVBSIncluded, locationOfUEs, UAVBSsSet)
    % UEsPositionOfUAVBSIncluded: UAVBS涵蓋住的所有UE座標(包含連線與未連線) {[],[],...}

    % 計算無人機範圍內的使用者數量
    % numOfUAVBSIncludingUE = zeros(size(UEsPositionOfUAVBSIncluded, 2), 1); % [UAV1; UAV2; UAV3;...]
    % for i=1:size(UEsPositionOfUAVBSIncluded, 2)
    %     numOfUAVBSIncludingUE(i,1) = size(UEsPositionOfUAVBSIncluded{i},1);
    % end
    
    % 列出每個UE被涵蓋住的所有UAV
    UAVIndexArrayOfUECoveredBy = {}; % UE被涵蓋住的所有UAV索引 {[id1,id2,...];[id1,id2,...];...}
    for i=1:size(locationOfUEs, 1)
        UAVIndexArrayOfUECoveredBy{i} = [];
        for j=1:size(UEsPositionOfUAVBSIncluded, 2)
            if nnz(ismember(locationOfUEs(i,:), UEsPositionOfUAVBSIncluded{j},'rows'))
                UAVIndexArrayOfUECoveredBy{i}(1,size(UAVIndexArrayOfUECoveredBy{i},2)+1) = j;
            end
        end
    end

    % 將每位使用者分配給一台無人機服務
    indexArrayOfUEsServedByUAVBS = zeros(size(locationOfUEs, 1), 1); % [id1; id2; id3;...]
    for i=1:size(locationOfUEs, 1)
        distances = pdist2(UAVBSsSet(UAVIndexArrayOfUECoveredBy{i},:), locationOfUEs(i,:));
        [~, index] = min(distances,[],1);
        indexArrayOfUEsServedByUAVBS(i,1) = UAVIndexArrayOfUECoveredBy{i}(1,index);
    end
end