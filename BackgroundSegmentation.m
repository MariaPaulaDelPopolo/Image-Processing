function [outputImage] = BackgroundSegmentation(image)

factor = DiagonalFactor(image);

threshold = graythresh(image);
maskImage = image < threshold;
se = strel('disk', 13 * factor);
maskImage = imopen(maskImage,se);
maskImage = imerode(maskImage, strel('disk', 6 * factor));
sigma = 10*factor;
maskImage = imgaussfilt(double(maskImage), sigma);
maskImage = maskImage > 0.25;


outputImage = maskImage;

end

