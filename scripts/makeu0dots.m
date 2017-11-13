% make u0

% B = double(imread('../img/coinss.png')); B = B(:,:,2); B=B./max(max(B)).*255;  param1=210;
% B = double(imread('../../img/coins3.png')); B = B(:,:,2); B=B./max(max(B)).*255; param1=40;

%[n,m] = size(B);
n=100;
m=100;

X_D = zeros(n,m);
u0 = zeros(n,m);
num = 1;
step = 40;

start1 = 2;
for i = start1:2:n-2
    for j = start1:2:m-2
        u0(i,j) = num;
        X_D(i,j) = 1;
        num = num + 1;
    end
end


start2 = 
for i = 2:step:n-2
    for j = start2:step:m-2
        u0(i,j) = num;
        X_D(i,j) = 1;
        num = num - 2;
    end
end

u02 = u0;
u02(1:end/2,1:end/2)=mean(mean(u0(1:end/2,1:end/2)))
u02(1:end/2,end/2:end)=mean(mean(u0(1:end/2,end/2:end)))
u02(end/2:end,1:end/2)=mean(mean(u0(end/2:end,1:end/2)))
u02(end/2:end,end/2:end)=mean(mean(u0(end/2:end,end/2:end)))
dispImage(u02)


% try this:
%     x2 = x;
%     v = x2(x2~=0);
%     mean1 = mean(v);
%     x2(x2~=0) = x(x~=0) - mean1./1.2
%     x2(x2~=0) = mean1 + (x2(x2~=0) - mean1).* (abs(x2(x2~=0) - mean1))
%     x3 = x2;
%     x3(x3 ~= 0) = mean(mean(x2(x2~=0))) - x2(x2~=0)
%     finally = x3(x3~=0) - min(min(x3(x3~=0))
