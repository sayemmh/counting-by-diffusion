function [data] = assignClusters1D(data, C)

[data_rows, ~] = size(data);
[C_rows, ~] = size(C);


for i = 1:data_rows
   D = Inf; % any better method?
   for j = 1:C_rows
       temp = ((data(i, 1) - C(j, 1)).^2).^(.5);
       if (temp < D)
           D = temp;
           data(i, 2) = j;
       end
   end
   
end

end

