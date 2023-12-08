function [outputImage] = SkullStripFilter(skuSegIm, bgrSegIm)

factor = DiagonalFactor(skuSegIm);

skuSegIm = imclose(skuSegIm, strel('disk', 15*factor));


maskImage = (skuSegIm + bgrSegIm) > 0.5;

maskImage = imclose(maskImage, strel('disk', 5*factor));
maskImage = imclose(maskImage, strel('disk', 20*factor));
sigma = 10*factor;
maskImage = imgaussfilt(double(maskImage), sigma);
maskImage = maskImage > 0.3;

outputImage = imcomplement(maskImage);

end

