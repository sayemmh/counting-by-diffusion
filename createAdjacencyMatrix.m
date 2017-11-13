function adjMat = createAdjacencyMatrix(KM_clust)

data = KM_clust.data;
sz = size(data(:,2));
adjMat = zeros(sz(1)+1);
adjMat(2:end,1) = data(:,2);
adjMat(1,2:end) = data(:,2);

data2 = zeros(sz(1),3);
data2(:,1) = 1:sz(1);
data2(:,2:3) = data;

for N = min(data2(:,3)):max(data2(:,3))
    Clust_N = data2(data2(:,3) == N, 1);
    adjMat(Clust_N',Clust_N') = 1;
    
end
adjMat(:,1) = []; adjMat(1,:) = [];

end
