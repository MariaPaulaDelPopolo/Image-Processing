function [outputImage] = BackgroundSegmentation(image)

threshold = graythresh(image);
mask_background = image < threshold;
% se = strel('disk', 1);
% mask_background = imclose(mask_background,se);
se = strel('disk', 13);
mask_background = imopen(mask_background,se);
mask_background = imerode(mask_background, strel('disk', 6));
% mask_background = mask_background - ((image .* mask_background) > 0);
% Smooth the edges using a Gaussian filter
% sigma = 3;
% mask_background = imgaussfilt(double(mask_background), sigma);
% 
% % Convert the smoothed image back to a binary image using a threshold
% mask_background = mask_background > 0.5;


outputImage = mask_background;

end

