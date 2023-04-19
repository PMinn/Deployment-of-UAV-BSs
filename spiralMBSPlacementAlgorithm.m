function [UAVBSsSet] = spiralMBSPlacementAlgorithm(locationOfUEs, r_UABBS)
    % Initialization
    uncoveredUEsSet = locationOfUEs;
    UAVBSsSet = [];
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
        [u, Pprio] = localCover(r_UABBS, centerUE, centerUE, setdiff(uncoveredUEsSet, centerUE, 'rows'));
        newBoundaryUEsSet = Pprio;

        % 4
        [u, Pprio] = localCover(r_UABBS, u, newBoundaryUEsSet, uncoveredInnerUEsSet);
        newPositionOfUAVBS = u;
        newUEsSet = Pprio;

        % 5
        UAVBSsSet(size(UAVBSsSet,1)+1,:) = newPositionOfUAVBS;
        uncoveredUEsSet = setdiff(uncoveredUEsSet, newUEsSet, 'rows');
        m = m+1;

        % 6
        tempUEsSet = setdiff(uncoveredBoundaryUEsSet, newBoundaryUEsSet, 'rows');
        if ~isempty(tempUEsSet)
            centerUE = tempUEsSet(1,:);
        else
            return
        end
    end
end