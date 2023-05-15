function [UAVBSsSet, UAVBSsR] = ourAlgorithm(minHeight, maxHeight, maxNumOfUE, locationOfUEs)
    % maxHeight: 法定最高高度
    % maxNumOfUE: 無人機符合滿意度之下，能服務的最大UE數量
    % locationOfUEs: 所有UE的位置 []
    % UAVBSsSet: 所有無人機的位置 []

    minR = getAreaByHeight(minHeight); % 依照法定最低高度推算最小半徑
    maxR = getAreaByHeight(maxHeight); % 依照法定最高高度推算最大半徑
    angle = 90; % 旋轉排序的起始角度(0~360deg)

    % Initialization
    uncoveredUEsSet = locationOfUEs;
    UAVBSsSet = [];
    UAVBSsR = [];
    centerUE = [];

    % 演算法第1行
    [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(false, uncoveredUEsSet, angle); % 找出邊緣並以逆時針排序
    while ~isempty(uncoveredUEsSet)
        % 演算法第2行
        uncoveredInnerUEsSet = setdiff(uncoveredUEsSet, uncoveredBoundaryUEsSet, 'rows');
        centerUE = uncoveredBoundaryUEsSet(1,:);

        % 演算法第3~4行
        r_UAVBS = minR;
        [newPositionOfUAVBS, newUEsSet] = cover(r_UAVBS, centerUE, uncoveredBoundaryUEsSet, uncoveredInnerUEsSet);
        sizeOfNewUEsSet = size(newUEsSet,1);
        if sizeOfNewUEsSet < maxNumOfUE
            innerR = minR;
            outerR = maxR;
            times = 0;
            while 1
                r_UAVBS = (outerR+innerR)/2;
                [newPositionOfUAVBS, newUEsSet] = cover(r_UAVBS, centerUE, uncoveredBoundaryUEsSet, uncoveredInnerUEsSet);
                if size(newUEsSet,1) == sizeOfNewUEsSet
                    times = times+1;
                    if times >= 7
                        break
                    end
                end
                sizeOfNewUEsSet = size(newUEsSet,1);
                if sizeOfNewUEsSet > maxNumOfUE
                    outerR = r_UAVBS;
                elseif sizeOfNewUEsSet < maxNumOfUE
                    innerR = r_UAVBS;
                else
                    break
                end
            end
        end

        % 演算法第5行
        % 更新結果
        UAVBSsSet(size(UAVBSsSet,1)+1,:) = newPositionOfUAVBS;
        uncoveredUEsSet = setdiff(uncoveredUEsSet, newUEsSet, 'rows');
        UAVBSsR(size(UAVBSsR,1)+1,1) = r_UAVBS;

        % 演算第6行
        % 以不更改排序的情況下移除未覆蓋邊緣集合裡已覆蓋的邊緣點
        commonRows = ismember(uncoveredBoundaryUEsSet, newUEsSet, 'rows');
        uncoveredBoundaryUEsSet(commonRows,:) = [];
        if ~isempty(uncoveredBoundaryUEsSet)
            centerUE = uncoveredBoundaryUEsSet(1,:);
        else
            [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(false, uncoveredUEsSet, angle);
        end
    end
end