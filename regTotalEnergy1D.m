function E = regTotalEnergy1D(data, C, lambda)

% To calculate the total energy, the energy for each cluster must be
% calculated, and those energies have to be summed up.

% C is the Nx2 input centers matrix. The 1st row is the coordinates for 
% the 1st cluster, 2nd is for 2nd, etc...
%
%
% data is an Nx3 input matrix with the first two columns containing the
% coordinates for each data point. The 3rd column is the current cluster
% each data point is in currently.
% example:
%              data = [2    3    1 ;      (2,3) and (0,9) are in cluster 1
%                      0    9    1 ;
%                      3    6    2 ;      (3,6) and (1,4) are in cluster 2
%                      1    4    2 ]

% lambda = 5;%1e2;
E = 0;

lambda = lambda + lambda * range(data(:,1));
for N = min(data(:,2)):max(data(:,2))
    % getting the N-th cluster from data
    Clust_N = data(data(:,2) == N, 1);
    [rows,~] = size(Clust_N);
    
    % calculate energy for cluster y
    E = E + sum((Clust_N(:,1) - C(N,1)).^2);
    E = E + lambda*1/(rows + 1e-4);
end
