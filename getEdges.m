function edges = getEdges(fname)
  
B = double(imread('../../img/tvr-ed_cells1.jpg')); B = B(:,:,2); B=B/max(max(B))*255;
d1=dxb(B); d2=dxf(B); d3=dyb(B);d4=dyf(B);
vartv=sqrt(d1.^2+ d2.^2+d3.^2+ d4.^2);
lambda = 1;
B_edge = exp(lambda*-0.0003*vartv.^2);
image (B_edge*255); colormap(gray(256));

end
