function [randCenters] = makeCenter1D(K, data)

lo1 = min(data(:,1));
hi1 = max(data(:,1));

randCenters = zeros(K, 1);
for x = 1:K
    randCenters(x, :) = lo1 + (hi1-lo1).* rand(1);
end

end
