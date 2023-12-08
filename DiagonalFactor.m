function [F] = DiagonalFactor(image)

[L, B] = size(image);

D = sqrt(L*L + B*B);

F = round(D/320);

end

