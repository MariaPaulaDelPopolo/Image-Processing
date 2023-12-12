function [D] = DiagonalFactor(image)

[L, B] = size(image); % get size
D = sqrt(L*L + B*B); % calculate diagonal

end

