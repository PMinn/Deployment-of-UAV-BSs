function [UAVBSsSet, UAVBSsR, UEsPositionOfUAVServedBy] = randomAlgorithm(locationOfUEs, rangeOfPosition, config)
    % config.minR: 法定最低半徑
    % config.maxR: 法定最高半徑
    % locationOfUEs: 所有UE的位置 []
    % UAVBSsSet: 所有無人機的位置 []
    % UEsPositionOfUAVServedBy: 所有無人機連線到的UE {[;;...],[;;...],...}
    % UAVBSsR: 所有無人機的半徑 [;;...]

    % Initialization
    UAVBSsSet = [];
    UAVBSsR = [];
    UEsPositionOfUAVServedBy = {};
    centerUE = [];
    uncoveredUEsSet = locationOfUEs;

    while ~isempty(uncoveredUEsSet)
        % 產生無人機位置及半徑
        newPositionOfUAVBS = randi([0 rangeOfPosition],1,2);
        r = rand(1,1) * (config("maxR") - config("minR")) + config("minR");

        distances = pdist2(uncoveredUEsSet, newPositionOfUAVBS);
        indexes = find(distances(:,1) <= r);
        if ~isempty(indexes)
            UAVBSsSet(size(UAVBSsSet,1)+1,:) = newPositionOfUAVBS;
            UAVBSsR(size(UAVBSsR,1)+1,1) = r;
            UEsPositionOfUAVServedBy{1,size(UEsPositionOfUAVServedBy,2)+1} = uncoveredUEsSet(indexes,:);
            uncoveredUEsSet(indexes,:) = [];
        end
        % commonRows = ismember(uncoveredBoundaryUEsSet, newUEsSet, 'rows');

        % uncoveredInnerUEsSet = setdiff(uncoveredUEsSet, uncoveredBoundaryUEsSet, 'rows');

        % centerUE = uncoveredBoundaryUEsSet(1,:);

        % 涵蓋
        % [newPositionOfUAVBS, newUEsSet, r] = ourLocalCover(centerUE, centerUE, setdiff(uncoveredUEsSet, centerUE, 'rows'), locationOfUEs, maxNumOfUE, config);

        % 演算法第5行
        % 更新結果
        

        % 演算第6行
        % 以不更改排序的情況下移除未覆蓋邊緣集合裡已覆蓋的邊緣點
        % commonRows = ismember(uncoveredBoundaryUEsSet, newUEsSet, 'rows');
        % uncoveredBoundaryUEsSet(commonRows,:) = [];
        % if isempty(uncoveredBoundaryUEsSet)
        %     [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(false, uncoveredUEsSet, angle);
        % end
    end
end