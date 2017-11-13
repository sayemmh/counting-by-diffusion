function [B_edges] = edgeFunction(B,lambda)
[r,c,~] = size(B);
uxf = (B(:,[2:c,c]) - B)./1;
uyf = (B([2:r,r],:) - B)./1;
du = (uxf.^2 + uyf.^2).^(0.5);

B_edges  = gFunction(du, lambda);

% d1=dxb(B); d2=dxf(B); d3=dyb(B);d4=dyf(B);
% vartv=sqrt(d1.^2+ d2.^2+d3.^2+ d4.^2);
% edge_lambda = 1e1;
% B_edges = exp(edge_lambda*-0.0003*vartv.^2);

end
