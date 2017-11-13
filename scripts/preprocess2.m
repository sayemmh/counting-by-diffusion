% TVR
% gFunction
% new edge function
% b(b > 0.9775) = 0.5
img = 'lesions1.png';
B_old = tvreduction(img);
B = gFunction(B_old, 125);

Bred = B./max(max(B));

% ll=edgeFunction(a)
% dispImage(ll)
% dispImage(a)
% a = a.^5;
% b=a;
% 
% [r,c]=size(b);
% threshold=sum(sum(b))./(r*c) * 1.15;
% 
% b(b>threshold)=0.2;
% B=b./max(max(b)).*255;thres
b=gFunction(Bred, 2);
b=b.^4;
threshold = 0.82;
% threshold=sum(sum(b))./(r*c) * 2;
b(b<threshold)=0.5*b(b<threshold);
dispImage(b)

bex=b;
bex(bex<threshold) = 0;
B=b./max(max(b)).*255;

B = edgeFunction(B, 1);
dispImage(B)
