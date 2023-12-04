function [outputImage] = skull_segmentation4(image,mask_background,i)

test = image > 30;
%mask = zeros(size(test));
%mask(110:size(test,1)-110, 50:size(test,2)-50) = 1; 

% [mask] = erode_max(test)
% mask = bwareafilt(mask,1)

mask = imerode(test,strel('disk', 1));
%mask = imfill(mask,"holes");
% mask = imclose(mask,strel('disk', 5));


mask = bwareafilt(mask,1);
mask = imfill(mask,"holes");
mask = imerode(mask,strel('disk', 5));
mask = imclose(mask,strel('disk', 20));
mask = imopen(mask,strel('disk', 10));
mask = imerode(mask,strel('disk', 17));

% Display the initial contour
figure(2);
subplot(3,5,i)
imshow(image);
hold on;
contour(mask, [0.5, 0.5], 'r');
title('Initialization of Deformable Contour');

% Run active contour (snakes) to refine the contour
bw = activecontour(image,mask,5000,"Chan-Vese","SmoothFactor",1,"ContractionBias",-0.2);  % 500 iterations (adjust as needed)
bw = imfill(bw,"holes")
bw = imclose(bw,strel('disk', 20))
bw = imdilate(bw,strel('disk', 5))

% Display the final contour after refinement
figure(3);
subplot(3,5,i)
imagesc(image);
hold on;
contour(bw, [0.5, 0.5], 'r');
title('Deformable Contour After Refinement');

outputImage = image; 
outputImage(bw==1)=0;
outputImage = outputImage > 0; 
outputImage = bwareafilt(outputImage,[250 1000000000000]);


end 