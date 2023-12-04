function [thrImage, outputImage] = BackgroundSegementation(image);
% filtering (not sure if necassary)  
HSIZE=1;
element = fspecial('average',HSIZE);
%image = imfilter(image,element);

% segment background 
mask_background = image > 40;
se = strel('disk', 15);
thrImage = imclose(mask_background,se); % take complement for background

% segment skull 
outputImage = image.*mask_background; 
end 