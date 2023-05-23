function [UAVposition, r] = getUAVPositionAndRByUEs(UEsSet)
    if size(UEsSet,1) == 1
        UAVposition = UEsSet(1,:);
        r = 0;
        return;
    end

    if size(UEsSet,1) == 2
        UAVposition = [mean(UEsSet(:, 1)), mean(UEsSet(:, 2))];
        r = max(pdist2(UAVposition, UEsSet), [], "all");
        return;
    end

    % 凸包
    boundaryUEsSet = convhull(UEsSet);
    boundaryUEsSet = UEsSet(boundaryUEsSet,:);
    boundaryUEsSet(1,:) = [];

    % 外心
    r = 1/0;
    for i=1:size(boundaryUEsSet,1)-2
        for j=i+1:size(boundaryUEsSet,1)-1
            for k=j+1:size(boundaryUEsSet,1)
                triangle = triangulation([1,2,3], [boundaryUEsSet(i,:);boundaryUEsSet(j,:);boundaryUEsSet(k,:)]);
                center = circumcenter(triangle);
                tempR = max(pdist2(center, UEsSet), [], "all");
                if tempR < r
                    r = tempR;
                    UAVposition = center;
                end
            end
        end
    end

    % 重心
    newUAVposition = [mean(boundaryUEsSet(:, 1)), mean(boundaryUEsSet(:, 2))];
    newR = max(pdist2(UEsSet, newUAVposition),[],1);
    if newR < r
        r = newR;
        UAVposition = newUAVposition;
    end
end