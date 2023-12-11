function [outputImage] = SkullStripFilter(skuSegIm, bgrSegIm)

D = DiagonalFactor(skuSegIm);

skuSegIm = imclose(skuSegIm, strel('disk', round(0.0500*D)));


maskImage = (skuSegIm + bgrSegIm) > 0.5;

maskImage = imclose(maskImage, strel('disk', round(0.0167*D)));
maskImage = imclose(maskImage, strel('disk', round(0.0667*D)));
sigma = round(0.0333*D);
maskImage = imgaussfilt(double(maskImage), sigma);
maskImage = maskImage > 0.3;

outputImage = imcomplement(maskImage);

end

