function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

maskedImage = image .* (skullStripped - csfSegIm);

[minimum, nrPeaks] = LocalMinimum(maskedImage, 2, 0.5);

% if nrPeaks < 2
%     maxVal = max(image(:));
%     minVal = min(image(:));
%     threshold = minVal + ((maxVal - minVal) / 2);
% else
%     threshold = minimum;
% end
threshold = 0.9 *minimum;
whmSegIm = maskedImage > threshold;
whmSegIm = whmSegIm - imcomplement(skullStripped);
% whmSegIm = imopen(whmSegIm, strel('disk', 1));

outputImage = whmSegIm;

end

