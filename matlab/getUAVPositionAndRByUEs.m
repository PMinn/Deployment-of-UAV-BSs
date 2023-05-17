function [position, r] = getUAVPositionAndRByUEs(UEsSet, minR)
    if size(UEsSet,1) == 1
        position = UEsSet(1,:);
        r = minR;
        return;
    end

    if size(UEsSet,1) == 2
        position = [mean(UEsSet(:, 1)), mean(UEsSet(:, 2))];
        r = max(pdist2(position, UEsSet), [], "all");
        return;
    end

    % 凸包
    boundaryUEsSet = convhull(UEsSet);
    boundaryUEsSet = UEsSet(boundaryUEsSet,:);
    boundaryUEsSet(1,:) = [];

    % 計算
    position = [mean(boundaryUEsSet(:, 1)), mean(boundaryUEsSet(:, 2))];
    r = max(pdist2(position, UEsSet), [], "all");
end