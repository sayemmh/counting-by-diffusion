function u = peronamalik(u, iterations)


a = 25;
u = double(u);

dt = 0.1;
h = 1;
[r,c] = size(u);

for t = 1:iterations

        uxf = (u(:,[2:c,c]) - u) ./ h;
        uyf = (u([2:r,r],:) - u) ./ h;

        %uxb = (u - u(:, [1, 1:c-1])) ./ h;
        %uyb = (u - u([1, 1:r-1], :)) ./ h;

        p = ((uxf.^2 + uyf.^2).^0.5);
        % p = ((uxb.^2 + uyb.^2).^0.5);
        gu = 1 ./ (1 + p.^2 ./ a.^2);

        %gu = 1 ./ ((1 + p.^2) ^0.5);

        guxf = gu .* uxf;
        guyf = gu .* uyf;

        guxfb = (guxf - guxf(:, [1, 1:c-1])) ./ h;
        guyfb = (guyf - guyf([1,1:r-1], :)) ./ h;

        u_out = u + dt .* (guxfb + guyfb);
        u = u_out;
end

end
