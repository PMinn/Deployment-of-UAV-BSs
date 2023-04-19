function [UAVBSsSet, UAVBSsRange] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UABBS)
    % Initialization
    uncoveredUEsSet = locationOfUEs;
    UAVBSsSet = [];
    UAVBSsRange = {};
    m = 1;

    centerUE = [];

    % Algorithm
    % 1
    while ~isempty(uncoveredUEsSet)
        % 2
        [uncoveredBoundaryUEsSet] = findBoundaryUEsSet(uncoveredUEsSet)
        uncoveredInnerUEsSet = setdiff(uncoveredUEsSet, uncoveredBoundaryUEsSet, 'rows');
        if m == 1
            centerUE = uncoveredBoundaryUEsSet(1,:);
        end

        % 3
        [firstLocalCoverU, firstLocalCoverPprio] = localCover(r_UABBS, centerUE, centerUE, setdiff(uncoveredUEsSet, centerUE, 'rows'));
        newBoundaryUEsSet = firstLocalCoverPprio;

        % 4
        [secondLocalCoverU, secondLocalCoverPprio] = localCover(r_UABBS, firstLocalCoverU, newBoundaryUEsSet, uncoveredInnerUEsSet);
        newPositionOfUAVBS = secondLocalCoverU;
        newUEsSet = secondLocalCoverPprio;

        % 5
        UAVBSsSet(size(UAVBSsSet,1)+1,:) = newPositionOfUAVBS;
        UAVBSsRange{size(UAVBSsRange,2)+1} = newUEsSet;
        uncoveredUEsSet = setdiff(uncoveredUEsSet, newUEsSet, 'rows');
        m = m+1;

        % 6
        tempUEsSet = setdiff(uncoveredBoundaryUEsSet, newBoundaryUEsSet, 'rows');
        if ~isempty(tempUEsSet)
            centerUE = tempUEsSet(1,:);
        end
    end
end