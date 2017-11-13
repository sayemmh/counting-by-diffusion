v = histogram(x2(x2~=0), histBins);
v = v.Values;
v(v<10)=0;
objs = zeros(1, length(v));
j = 1;
for i = 1:length(v)
  if v(i) ~= 0
    objs(j) = objs(j) + v(i);
  elseif v(i) == 0
    j = j + 1;
  end
end

objs = objs(objs > threshold1);

a = regKMeans(objs', lambdaK);

number_objects = length(objs)
number_different_sized_objects = a.K
centers = a.data


subplot(3,2,1)
dispImage(B_orig)
title('Original image')

subplot(3,2,2)
dispImage(u0)
title('u0 grid')

subplot(3,2,3)
dispImage(B)
title('Image after TVR and gFunction')

subplot(3,2,4)
dispImage(B_edge)
title('Edges of image')

subplot(3,2,5)
histogram(x2(x2~=0), histBins)
title('Histogram after diffusion')
