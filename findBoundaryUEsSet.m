function [boundaryUEsSet, UEsSetStartAngle] = findBoundaryUEsSet(UEsSet, UEsSetStartAngle)
    if size(UEsSet,1) <= 2
        boundaryUEsSet = UEsSet;
        return
    end

    % 凸包
    % boundaryUEsSet = convhull(UEsSet);
    % boundaryUEsSet = UEsSet(boundaryUEsSet,:);
    % boundaryUEsSet(1,:) = [];

    % 邊緣
    xArrayFromUEsSet = UEsSet(:,1); % UE的x座標陣列
    yArrayFromUEsSet = UEsSet(:,2); % UE的y座標陣列
    boundaryUEsSet = boundary(xArrayFromUEsSet,yArrayFromUEsSet,0); % 邊界上的UE集合
    boundaryUEsSet = UEsSet(boundaryUEsSet,:);
    boundaryUEsSet(1,:) = [];

    center = [mean(UEsSet(:, 1)), mean(UEsSet(:, 2))];
    vectorInCenter = boundaryUEsSet - repelem(center,size(boundaryUEsSet, 1),1);
    angles = zeros(size(boundaryUEsSet, 1), 1);
    for i=1:size(boundaryUEsSet, 1)
        angles(i) = atan2(vectorInCenter(i,2),vectorInCenter(i,1)) * 180 / pi;
        if angles(i) < 0
            angles(i) = angles(i)+360;
        end
    end
    anglesWithOffset = angles - UEsSetStartAngle;
    for i=1:size(anglesWithOffset, 1)
        if anglesWithOffset(i) < 0
            anglesWithOffset(i) = anglesWithOffset(i)+360;
        end
    end
    [anglesWithOffset, index] = sort(anglesWithOffset);%, 'descend'
    angles = angles(index,:);
    boundaryUEsSet = boundaryUEsSet(index,:);
    UEsSetStartAngle = angles(size(angles, 1),1);
end