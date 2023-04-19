function [u, Pprio] = localCover(r_UAVBS, u, Pprio, Psec)
    % r_UAVBS: 無人機的涵蓋範圍
    % u: 當前無人機位置，向量形式[x,y]
    % Pprio: 無人機涵蓋的UE
    % Psec: 未被覆蓋的UE
    
    % 1
    while ~isempty(Psec)
        % 2
        distances = pdist2(Psec, u);
        i = 1;
        while 1
            if i > size(distances, 1)
                break
            end
            disp(distances)
            if distances(i,1) > 2*r_UAVBS
                Psec(i,:) = [];
                distances(i,:) = [];
                i = i-1;
            end
            i = i+1
        end


        distances = pdist2(Psec, u);
        i = 1;
        while 1
            if i > size(distances, 1)
                break
            end
            if distances(i,1) <= r_UAVBS
                Pprio(size(Pprio, 1)+1,:) = Psec(i,:);
                Psec(i,:) = [];
                distances(i,:) = [];
                i = i-1;
            end
            i = i+1
        end


        % 3
        distances = pdist2(Psec, u);
        if size(distances,1) > 0
            [~, indexOfShortestDistances] = min(distances,[],1)
            newPprio = Pprio;
            newPprio(size(newPprio,1)+1,:) = Psec(indexOfShortestDistances,:);
            newU = [mean(newPprio(:, 1)), mean(newPprio(:, 2))];
            for j=1:size(newPprio, 1)
                distances = pdist2(newPprio(j,:), newU);
                if distances > r_UAVBS
                    return
                end
            end
            Pprio = newPprio;
            Psec(indexOfShortestDistances,:) = [];
            u = newU;
        else
            return
        end
    end
end