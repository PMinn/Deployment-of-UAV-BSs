function L = getPathLoss(locationOfUEs, UAVBSsSet, UAVBSsR, config)
    L = zeros(size(locationOfUEs,1),size(UAVBSsSet,1));
    heights = zeros(size(UAVBSsSet,1),1);
    for i = 1:size(UAVBSsSet,1)
        heights(i,1) = getHeightByArea(UAVBSsR(i,1));
    end
    for i = 1:size(locationOfUEs,1)
        for j = 1:size(UAVBSsSet,1)
            r = pdist2(locationOfUEs(i,:), UAVBSsSet(j,:));
            theta = atan(heights(j,1)/r);
            L(i,j) = (config("etaLos")-config("etaNLos"))/(1+config("a")*exp(-config("b")*(180/pi*theta-config("a"))))+20*log(4*pi*config("frequency")/config("constant"))+20*log(r*sec(theta))+config("etaNLos");
        end
    end
end