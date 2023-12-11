function [outputImage] = WhiteMatterSegmentation(image, csfSegIm, skullStripped)

mask = (skullStripped - csfSegIm);

% figure;
% subplot(1,2,1);
% imshow(mask);
% 
% mask = bwareafilt(logical(mask), 1);
% subplot(1,2,2);
% imshow(mask);


[crossPoint] = CrossPointGauss(image(image > 0), 2, 0.5);

threshold = crossPoint;
whmSegIm = (image .* mask) > threshold;
% whmSegIm = whmSegIm - imcomplement(skullStripped);

outputImage = whmSegIm;

end

