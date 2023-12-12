function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

mask = (skullStripped - csfSegIm);

% Choose threshold based on gaussian curves, keep trying till valid
% threshold is found
count = 0;
threshold = 0;
while (count < sum(mask(:) > 1) * 0.3) || (threshold < 0.2)
    threshold = CrossPointGauss(image(mask > 0), 2, 0.4);
    count = sum((image(:) .* mask(:)) < threshold);
end

% threshold largest component
whmSegIm = (image .* bwareafilt(logical(mask), 1)) > (threshold);
outputImage = whmSegIm;

end

