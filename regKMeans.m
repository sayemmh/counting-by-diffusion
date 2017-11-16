% load('u_with_D_edge.mat')
% data = vals;
function KM_clust = regKMeans(vals, lambda)
data = vals;
K = 1;
data(:,2) = 1;
% lambda = 1e4;
% Initial Centers
C = makeCenter1D(K, data);
Energies = zeros(4,1);
E_old = Inf;
E_cur = regTotalEnergy1D(data, C, lambda);
decreasing = E_old - E_cur > 0;


% for each K, run the function 4 times, store all the energy values
while decreasing
    for row = 1:4
        [E_cur, data, C] = kmeansFunction1D(data, K, lambda);
        Energies(row,K) = E_cur;
            save(['temp/' int2str(K) '/C' int2str(row)], 'C');
            save(['temp/' int2str(K) '/data' int2str(row)], 'data');
    end
    if K == 10
        break
    end
    K = K + 1;
end

% Percent change in Energy < 0.10 used to determine 'best' K:
% "elbow method"
minEnergies = min(Energies);
dE = (minEnergies(2:end) - minEnergies(1:end-1));
percentChange = dE./minEnergies(1:end-1);
lessthan = find(percentChange > -0.1);
if all(size(lessthan)) == 0
    [~,K] = min(percentChange);
else
    K = lessthan(1);
end
[~,min_row] = min(Energies(:,K));

load(['temp/' int2str(K) '/C' int2str(min_row)]) % load C of clustering with min energy
load(['temp/' int2str(K) '/data' int2str(min_row)]) % load data of clustering with min energy


E_cur = regTotalEnergy1D(data, C, lambda);

KM_clust.lambda = lambda;
KM_clust.Energies = Energies;
KM_clust.minEnergies = minEnergies;
KM_clust.dE = dE;
KM_clust.minEnergy = E_cur;
KM_clust.K = K;
KM_clust.data = data;
KM_clust.centers = C;

end
