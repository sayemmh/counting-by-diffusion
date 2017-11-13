% clear

load fakeobjects1.mat
% B = double(imread('../../img/shapesx.png')); B = B(:,:,2); B=B./max(max(B)).*255;
% B = double(imread('../../img/tvr-ed_amoeba.jpg')); B = B(:,:,2); B=B./max(max(B)).*255;
B=B./max(max(B)).*255;
[n,m] = size(B);

X_D = zeros(n,m);
u0 = zeros(n,m);
num = 1;
step = floor((n*m)^(1/3));
for i = 15:step:n-10
    for j = 15:step:m-10
        u0(i,j) = num;
        X_D(i,j) = 1;
        num = num + 2;
    end
end
% save u0.mat u0
% save mask.mat X_D

% load u0.mat,
% load mask.mat,
%image (X_D); colormap(gray(256));

d1=dxb(B); d2=dxf(B); d3=dyb(B);d4=dyf(B);
vartv=sqrt(d1.^2+ d2.^2+d3.^2+ d4.^2);
edge_lambda = 1e1;
B_edge = exp(edge_lambda*-0.0003*vartv.^2);
B_edge(B_edge < 1e-1) = 0;
image (B_edge*255); colormap(gray(256));
M = max(max(B_edge));

rho = 1; theta = 0 ; % theta is added for stability, can be set to zero!
A = zeros(n, m);
for i = 1:n
    for j = 1:m
        A(i,j)= theta+ rho - 4*M *(cos(2*pi*(i-1)/n)+ cos(2*pi*(j-1)/m)-2);
    end
end

u = u0; mu = 1e3; v=u0; lambda = u; C = B_edge-M;
isConverged = false; iter = 0;
tic

while ~isConverged


    u_old = u;
    % u-sub
    ux = dxf(u); uy = dyf(u);
    g = theta*u + 2* dxb(C.* ux)+2*dyb(C.* uy)+ rho *v +lambda;
    u = real(ifftn(fftn (g)./ A));

    v =(mu.*X_D.*u0+rho.*u-lambda)./(mu.*X_D+rho);

    lambda = lambda + rho*(v-u);

    if mod(iter,10)==0,
%         image(u*255); colormap(gray(256));
%         surf(u)

        show=u/max(max(u));
        show(:,:,2)=show(:,:,1);
        show(:,:,3)=show(:,:,1);
%         image(show)
        surf(u)

        snapnow
    end

    iter
    u_change=abs(sum(sum(u_old - u)))
    if iter > 200 && u_change < 1e3
        X_D = zeros(n,m);
        if iter > 750
            isConverged = iter > 1.5e2 && u_change < 1e-13;
        end
    end
    iter = iter + 1;
end

u(~B_edge) = 0;

toc
figure(1); surf(u)
figure(2); imshow(u)

show=u/max(max(u));
show(:,:,2)=show(:,:,1);
show(:,:,3)=show(:,:,1);
image(show)


a = histogram(u);
objs = a.Values(2:end);
kmeans(objs', 3);
