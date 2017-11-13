function [gt] = gFunction(t, a)

    gt = 1./(1 + (t./a).^2);
    
%     gt(gt < 1e-1) = 0;

end
