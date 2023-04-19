function [UAVBSsSet, UAVBSsRange] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UAVBS)
    % Initialization
    uncoveredUEsSet = locationOfUEs;
    UAVBSsSet = [];
    UAVBSsRange = {};
    m = 1;

    centerUE = [];
    angle = 0
    % Algorithm
    % 1
    [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(uncoveredUEsSet, angle);
    while ~isempty(uncoveredUEsSet)
        % 2
        uncoveredInnerUEsSet = setdiff(uncoveredUEsSet, uncoveredBoundaryUEsSet, 'rows');
        centerUE = uncoveredBoundaryUEsSet(1,:);
        % if m == 1
        %     centerUE = uncoveredBoundaryUEsSet(1,:);
        % end

        % 3
        [firstLocalCoverU, firstLocalCoverPprio] = localCover(r_UAVBS, centerUE, centerUE, setdiff(uncoveredBoundaryUEsSet, centerUE, 'rows'));
        newBoundaryUEsSet = firstLocalCoverPprio;
        disp('firstLocalCoverPprio')
        disp(firstLocalCoverPprio)

        % 4
        [secondLocalCoverU, secondLocalCoverPprio] = localCover(r_UAVBS, firstLocalCoverU, newBoundaryUEsSet, uncoveredInnerUEsSet);
        newPositionOfUAVBS = secondLocalCoverU;
        newUEsSet = secondLocalCoverPprio;
        disp('secondLocalCoverPprio')
        disp(secondLocalCoverPprio)
        
        % 5
        UAVBSsSet(size(UAVBSsSet,1)+1,:) = newPositionOfUAVBS;
        UAVBSsRange{size(UAVBSsRange,2)+1} = newUEsSet;
        uncoveredUEsSet = setdiff(uncoveredUEsSet, newUEsSet, 'rows');
        m = m+1;

        % 6
        commonRows = ismember(uncoveredBoundaryUEsSet, secondLocalCoverPprio,'rows');
        uncoveredBoundaryUEsSet(commonRows,:) = [];
        if ~isempty(uncoveredBoundaryUEsSet)
            centerUE = uncoveredBoundaryUEsSet(1,:);
        else
            [uncoveredBoundaryUEsSet, angle] = findBoundaryUEsSet(uncoveredUEsSet, angle);
        end
    end
end