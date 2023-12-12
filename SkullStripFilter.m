function [outputImage] = SkullStripFilter(skuSegIm, bgrSegIm)

D = DiagonalFactor(skuSegIm); % Diagonal of the image

% Combine closed skull segmentation whith backgroundsegmentation
skuSegIm = imclose(skuSegIm, strel('disk', round(0.0500*D)));
maskImage = (skuSegIm + bgrSegIm) > 0.5;
maskImage = imclose(maskImage, strel('disk', round(0.0667*D)));

% complement is brain only image
outputImage = imcomplement(maskImage);

end