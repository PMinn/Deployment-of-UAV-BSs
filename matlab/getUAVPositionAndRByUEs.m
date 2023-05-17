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

    % 找外心及半徑
    centers = []; % 外心
    diameters = []; % 直徑
    index = 0;
    for i=1:size(boundaryUEsSet,1)-1
        for j=i+1:size(boundaryUEsSet,1)
            index = index+1;
            centers(index,:) = [mean([boundaryUEsSet(i,1),boundaryUEsSet(j,1)]), mean([boundaryUEsSet(i,2),boundaryUEsSet(j,2)])];
            diameters(index,1) = pdist2(boundaryUEsSet(i,:),boundaryUEsSet(j,:));
        end
    end
    [diameter, index] = max(diameters);
    position = centers(index,:);
    r = diameter/2;
end