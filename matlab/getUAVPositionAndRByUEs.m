function [position, r] = getUAVPositionAndRByUEs(UEsSet)
    if size(UEsSet,1) == 1
        position = UEsSet(1,:);
        r = 0;
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

    % 找座標及半徑
    position = [mean(boundaryUEsSet(:,1)), mean(boundaryUEsSet(:,2))];
    distances = pdist2(UEsSet, position);
    r = max(distances);
end