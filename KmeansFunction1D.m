function [E, data, C] = KmeansFunction1D(data, K, lambda)

C = makeCenter1D(K,data);
E_old = Inf;
data = randClustering(data, C);
E_cur = regTotalEnergy1D(data, C, lambda);
reassignments = 0;

while E_old - E_cur > 0
    E_old = E_cur;
    C = reCalculateCenters1D(data, C);

    data = assignClusters1D(data, C);
    reassignments = reassignments + 1;
    E_cur = regTotalEnergy1D(data, C, lambda);

    if reassignments > 5 && E_old == E_cur
        C = makeCenter1D(K,data);
        reassignments = 0;
        E_old = Inf;
        E_cur = regTotalEnergy1D(data, C, lambda);
    end
end

E = E_cur;

end
