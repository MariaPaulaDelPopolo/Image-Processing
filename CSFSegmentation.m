function [outputImage] = CSFSegmentation(image, skullStripped)

maskedImage = image .* skullStripped;

% Choose threshold based on gaussian curves, keep trying till valid
% threshold is found
count = 0;
threshold = 0;
while (count < sum(maskedImage(:) > 1) * 0.1) || (threshold < 0.1)  
    threshold = CrossPointGauss(image(maskedImage > 0), 6, 0.2);
    count = sum((image(:) .* maskedImage(:)) < threshold);
end

% Threshold the masked image, remove everything not in the brain mask
csfSegIm = maskedImage < threshold;
csfSegIm = (csfSegIm - imcomplement(skullStripped)) > 0;

outputImage = csfSegIm;

end

