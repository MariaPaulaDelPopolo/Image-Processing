function [outputImage] = BackgroundSegmentation(image)

maxVal = max(image(:));
minVal = min(image(:));
threshold = ((maxVal - minVal) / 20);
mask_background = image < threshold;
se = strel('disk', 1);
mask_background = imclose(mask_background,se);
se = strel('disk', 12);
mask_background = imopen(mask_background,se);

% Smooth the edges using a Gaussian filter
sigma = 3;
mask_background = imgaussfilt(double(mask_background), sigma);

% Convert the smoothed image back to a binary image using a threshold
mask_background = mask_background > 0.5; % Adjust the threshold if needed


outputImage = mask_background;

end

