function [newPositionOfUAVBS, newUEsSet] = cover(r_UAVBS, centerUE, uncoveredBoundaryUEsSet, uncoveredInnerUEsSet)
    % 演算法第3行
    % 涵蓋邊緣點
    [firstLocalCoverU, firstLocalCoverPprio] = localCover(r_UAVBS, centerUE, centerUE, setdiff(uncoveredBoundaryUEsSet, centerUE, 'rows'));

    % 演算法第4行
    % 涵蓋內點
    [newPositionOfUAVBS, newUEsSet] = localCover(r_UAVBS, firstLocalCoverU, firstLocalCoverPprio, uncoveredInnerUEsSet);
end