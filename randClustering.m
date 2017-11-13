function data = randClustering(data, C)

[C_rows, ~] = size(C);
[data_rows,~] = size(data);

for x = 1:data_rows
    data(x,end) = randi(C_rows);
end

end

