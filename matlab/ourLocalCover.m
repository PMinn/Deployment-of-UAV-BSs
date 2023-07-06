function [u, Pprio, r] = ourLocalCover(u, Pprio, Psec, maxNumOfUE, config)
    % u: 當前無人機位置，向量形式[x,y]
    % Pprio: 無人機涵蓋的UE
    % Psec: 未被覆蓋的UE
    
    r = 0;
    % 演算法第1行
    while ~isempty(Psec)

        % 從Psec移除大於2r的UE
        % distances = pdist2(Psec, u);
        % indexes = find(distances(:,1) > 2*config("maxR"));
        % Psec(indexes,:) = [];

        % 把最近且合法的UE加入範圍
        distances = pdist2(Psec, u);
        [~, indexOfShortestDistances] = min(distances,[],1); % 最近UE的index
        newPprio = Pprio;
        newPprio(size(newPprio,1)+1,:) = Psec(indexOfShortestDistances,:);
        [newR, newU, ~] = ExactMinBoundCircle(newPprio);
        if newR > config("maxR")
            return;
        end
        Pprio = newPprio;
        Psec(indexOfShortestDistances,:) = [];
        u = newU;
        r = newR;
        if size(Pprio,1) >= maxNumOfUE
            return;
        end
    end
end