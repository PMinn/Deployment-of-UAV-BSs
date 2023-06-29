function UEsIndexOfUAVBSIncluded = getUEsIndexOfUAVBSIncluded(UAVBSsR, locationOfUEs, UAVBSsSet)
    UEsIndexOfUAVBSIncluded = cell(size(UAVBSsSet,1),1);

    for i=1:size(UAVBSsSet,1)
        UEsIndexOfUAVBSIncluded{i} = zeros(0,1);
        for j=1:size(locationOfUEs,1)
            if pdist2(UAVBSsSet(i,:), locationOfUEs(j,:)) <= UAVBSsR(i,1)
                UEsIndexOfUAVBSIncluded{i}(size(UEsIndexOfUAVBSIncluded{i},1)+1,1) = j;
            end
        end
    end
end