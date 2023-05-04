function [newPositionOfUAVBS, newUEsSet] = cover(r_UAVBS, centerUE, uncoveredBoundaryUEsSet, uncoveredInnerUEsSet)
    % 演算法第3行
    % 涵蓋邊緣點
    [firstLocalCoverU, firstLocalCoverPprio] = localCover(r_UAVBS, centerUE, centerUE, setdiff(uncoveredBoundaryUEsSet, centerUE, 'rows'));
    newBoundaryUEsSet = firstLocalCoverPprio;

    % 演算法第4行
    % 涵蓋內點
    [secondLocalCoverU, secondLocalCoverPprio] = localCover(r_UAVBS, firstLocalCoverU, newBoundaryUEsSet, uncoveredInnerUEsSet);
    newPositionOfUAVBS = secondLocalCoverU; % 最後的涵蓋中心 即為UAVBS的座標
    newUEsSet = secondLocalCoverPprio; % 最後的涵蓋範圍
end