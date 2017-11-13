function [C] = reCalculateCenters1D(data, C)

K = max(data(:,2));
for N = 1:K
    Clust_N = data(data(:,2) == N, :);
    
    [rows,~] = size(Clust_N);
    if rows == 0
        C = makeCenter1D(K, data);
        break;
    end
    Cent_N = sum(Clust_N(:,1))./rows;
    C(N, :) = Cent_N;
end

end
