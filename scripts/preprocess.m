clear
tic

B = double(imread('../img/orangeEdges.jpg')); B=B./max(max(B)).*255; param1=195;
B = imresize(B, 0.5); step=30;lambdaK=20;threshold1=20; histBins=500;


% making u0 and X_D grids
[n,m] = size(B); X_D = zeros(n,m); u0 = zeros(n,m);
num = 1; start = 2;
for i = start:step:n-2
    for j = start:step:m-2
        %u0(i,j) = round((10000).*rand(1) + 1);
        u0(i,j) = num;
        X_D(i,j) = 1;
        num = num + 1;
    end
end

% preprocessing: TVR + gFunction
B = tvrFunction(B, 40);
B(B < param1) = 0;
B = B./255;
bool = B;
bool(bool~=0) = 1;
bool(bool~=1) = 0;
bool = 1-bool;

dispImage(bool)

d1=dxb(B); d2=dxf(B); d3=dyb(B); d4=dyf(B);
vartv=sqrt(d1.^2+ d2.^2 + d3.^2 + d4.^2);
edge_lambda = 1;
B_edge = exp(edge_lambda*vartv.^2);
M = max(max(B_edge));
B_edge = B_edge-1;

B_edge(B_edge > 0) = 1;
isEdge=B_edge
isEdge(isEdge ~= 1) = 0;
isEdge=~isEdge
B_edge = round(~B_edge);
B_edge=edgeFunction(B_edge,0.0001);

dispImage(B_edge)
