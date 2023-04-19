function [u, Pprio] = localCover(r_UABBS, u, Pprio, Psec)
    % r_UABBS: 無人機的涵蓋範圍
    % u: 當前無人機位置，向量形式[x,y]
    % Pprio: 鄰居無人機位置，矩陣形式[n,2]，n為鄰居數量，每一行為一個鄰居無人機的位置向量[x,y]
    % Psec: 目標覆蓋區域，矩陣形式[n,2]，n為目標區域離散化後的點數，每一行為一個點的坐標[x,y]
    

    % disp('u')
    % disp(u)
    % disp('Pprio')
    % disp(Pprio)
    % disp('Psec')
    % disp(Psec)
    
    % distances = pdist2(Psec, u);
    % 1
    while ~isempty(Psec)
        % 2
        for i = 1:size(Psec, 1)
            if i > size(Psec, 1)
                break
            end
            distances = pdist2(Psec(i,:), Pprio);
            disp('distances')
            disp(distances)
            for j = 1:size(distances, 2)
                if distances(j) > 2*r_UABBS
                    Psec(i,:) = [];
                    i = i-1;
                    break;
                end
            end
        end
        
        distances = pdist2(Psec, u);
        for i = 1:size(distances, 1)
            if i > size(distances, 1)
                break
            end
            if distances(i)  <= r_UABBS
                Pprio(size(Pprio, 1)+1,:) = Psec(i,:);
                Psec(i,:) = [];
                distances(i,:) = [];
                i = i-1;
            end
        end

        % 3
        % 將平均值作為中心點坐標
        distances = pdist2(Psec, u);
        for i = 1:size(distances, 1)
            if i > size(distances, 1)
                break
            end
            if distances(i)  == min(distances)
                newPprio = Pprio;
                newPprio(size(newPprio,1)+1,:) = Psec(i,:);
                newU = [mean(Pprio(:, 1)), mean(Pprio(:, 2))];
                newDistances = pdist2(u, newU);
                if newDistances <= r_UABBS
                    Pprio = newPprio;
                    Psec(i,:) = [];
                    u = newU;
                end
                break
            end
        end
    end
end