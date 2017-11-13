clear
tic

B_orig = double(imread('img/coins1.png')); B_orig = B_orig(:,:,2); B_orig=B_orig./max(max(B_orig)).*255;  param1=210;
B = imresize(B_orig, 0.5); step = 15;lambdaK=0.1;threshold1=5; histBins=500;

%B_orig = double(imread('../img/bricks1.png')); B_orig = B_orig(:,:,2); B_orig=B_orig./max(max(B_orig)).*255;  param1=150;
%B = imresize(B_orig, 0.25); step = 6;lambdaK=0.1;threshold1=5; histBins=10000;

%B_orig = double(imread('../img/shapesx.png')); B_orig = B_orig(:,:,2); B_orig=B_orig./max(max(B_orig)).*255;  param1=210;
%B = imresize(B_orig, 0.5); step = 10;lambdaK=10;threshold1=2; histBins=500;

%B_orig = double(imread('../img/celegans.png')); B_orig = B_orig(:,:,2); B_orig=B_orig./max(max(B_orig)).*255; param1=170;
%B = imresize(B_orig, 0.5); step = 15;lambdaK=20;threshold1=20; histBins=500;

%B_orig = double(imread('../img/bee.png')); B_orig = B_orig(:,:,2); B_orig=B_orig./max(max(B_orig)).*255; param1=105;
%B = imresize(B_orig, 1); step = 10;lambdaK=20;threshold1=50; histBins=500;

% B_orig = double(imread('../img/orangeEdges.jpg')); B_orig=B_orig./max(max(B_orig)).*255; param1=195;
% B = imresize(B_orig, 0.5); step=30;lambdaK=20;threshold1=20; histBins=500;

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

B_edge(B_edge > 0.3) = 1;
isEdge=B_edge
isEdge(isEdge ~= 1) = 0;
isEdge=~isEdge
B_edge = round(~B_edge);
B_edge=getEdges2(B_edge,0.1);

dispImage(B_edge)

% FFT matrix
rho = 1; theta = 0;
A = zeros(n, m);
for i = 1:n
    for j = 1:m
        A(i,j)= theta + rho - 4*M *(cos(2*pi*(i-1)/n)+ cos(2*pi*(j-1)/m)-2);
    end
end

u = u0; mu = 1e3; v=u0; lambda = u; C = B_edge-M;
isConverged = false; iter = 0;

okay = 1

while ~isConverged
    u_old = u;
    % u-sub
    ux = dxf(u); uy = dyf(u);
    g = theta*u + 2* dxb(C.* ux)+2*dyb(C.* uy)+ rho *v +lambda;
    u = real(ifftn(fftn (g)./ A));

    v=(mu.*X_D.*u0+rho.*u-lambda)./(mu.*X_D+rho);
    lambda = lambda + rho*(v-u);

    if mod(iter,10)==0,
        image(u*255); colormap(gray(256));
        surf(u)
        show=u/max(max(u));
        show(:,:,2)=show(:,:,1);
        show(:,:,3)=show(:,:,1);
        surf(u)
        snapnow
    end

    iter
    u_change=abs(sum(sum(u_old-u)))
    if iter > 50 && u_change < 1e3
        X_D = zeros(n,m);
        if iter>500 && u_change<100 && okay
            u = u.*bool
            okay = 0;
        end
        if iter > 1500 && u_change < 100
            isConverged=1;
        end
    end
    iter = iter + 1
end


x=u;
x=x.*bool;
x=x.*isEdge;
x2 = x;
v = x2(x2~=0);
mean1 = mean(v);
x2(x2 ~= 0) = x2(x2 ~= 0) - mean1;

toc
