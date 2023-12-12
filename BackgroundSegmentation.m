function [outputImage] = BackgroundSegmentation(image)

D = DiagonalFactor(image); % Diagonal of the image

% Threshold to get everything but the background
threshold = graythresh(image)/2;
maskImage = image > threshold;

% Close the gaps, strel based on diameter
maskImage = imclose(maskImage,strel('disk', round(0.05*D))); 
maskImage = imcomplement(maskImage);

outputImage = maskImage;

end

