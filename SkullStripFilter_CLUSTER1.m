function [outputImage] = SkullStripFilter_CLUSTER1(image, bgrSegIm)

%erodedImage = imerode(image, strel('disk', 1));
% sigma = 1;
% erodedImage = imgaussfilt(double(erodedImage), sigma);
% image = image + imgradient(image);

% Compute the Euclidean distance transform
distanceTransform = bwdist(~logical(image));
gradientMagnitude = (imgradient(image));

markerImage = imextendedmin(gradientMagnitude, 1) & imextendedmin(distanceTransform, 1);

% Perform watershed transform
labelMatrix = watershed(bwdist(markerImage));


outputImage = labelMatrix;

end