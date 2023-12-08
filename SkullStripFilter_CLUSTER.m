function [outputImage] = SkullStripFilter_CLUSTER(image)
    erodedImage = imerode(image, strel('disk', 1));
    sigma = 1;
    erodedImage = imgaussfilt(double(erodedImage), sigma);

    % Perform k-means clustering
    idx = imsegkmeans(im2single(image), 3);

    % Find connected components and compute region properties
    stats = regionprops(idx, 'Area');

    % Find the labels of the brain regions
    [~, sorted_labels] = sort([stats.Area], 'descend');
    brain_region_labels = sorted_labels(2:3);

    % Create a binary mask for the brain regions
    brain_mask = ismember(idx, brain_region_labels);

    % Threshold image
    maxVal = max(image(:));
    minVal = min(image(:));
    threshold1 = minVal + ((maxVal - minVal) / 5);
    threshold2 = minVal + (17 * (maxVal - minVal) / 20);
    thrImage = erodedImage > threshold1 & erodedImage < threshold2;
    thrImage = imopen(thrImage, strel('disk', 2));
    thrImage = imclose(thrImage, strel('disk', 1));
    % figure(1)
    % imshow(thrImage);

    % Morphological operations for refinement
    se1 = strel('disk', 6);
    se2 = strel('disk', 4);
    brain_mask = imerode(brain_mask, se1);
    skullStripped = conditional_dilation(brain_mask, thrImage, strel('disk', 1), 100);
    skullStripped = imdilate(skullStripped, se2);

    % Gaussian filtering and additional thresholding
    sigma = 10;
    skullStripped = imgaussfilt(double(skullStripped), sigma);
    skullStripped = skullStripped > 0.3;

    % Additional morphological operation for smoothing
    skullStripped = imopen(skullStripped, strel('disk', 25));

    outputImage = skullStripped;
end