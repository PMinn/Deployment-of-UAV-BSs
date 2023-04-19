function [boundaryUEsSet] = findBoundaryUEsSet(UEsSet)
    if size(UEsSet,1) <= 2
        boundaryUEsSet = UEsSet;
        return
    end
    disp('UEsSet')
    disp(UEsSet)
    xArrayFromUEsSet = UEsSet(:,1); % UE的x座標陣列
    yArrayFromUEsSet = UEsSet(:,2); % UE的y座標陣列
    boundaryUEsSet = boundary(xArrayFromUEsSet,yArrayFromUEsSet,0.1); % 邊界上的UE集合
    disp('xArrayFromUEsSet(boundaryUEsSet)')
    disp(xArrayFromUEsSet(boundaryUEsSet))
    disp('yArrayFromUEsSet(boundaryUEsSet)')
    disp(yArrayFromUEsSet(boundaryUEsSet))
    polyin = polyshape({xArrayFromUEsSet(boundaryUEsSet)}, {yArrayFromUEsSet(boundaryUEsSet)});
    polyout = sortboundaries(polyin,'numsides','descend'); % 逆時針
    [polyoutX, polyoutY] =  boundary(polyout,1);
    boundaryUEsSet = [polyoutX polyoutY];
    boundaryUEsSet(1,:) = [];
end