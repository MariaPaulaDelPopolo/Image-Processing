function [outputImage] = BackgroundSegmentation(image)

D = DiagonalFactor(image);

threshold = graythresh(image)/2;
maskImage = image > threshold;
maskImage = imclose(maskImage,strel('disk', round(0.05*D))); % take complement for background
maskImage = imcomplement(maskImage);

outputImage = maskImage;

end

