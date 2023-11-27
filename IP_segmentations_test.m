image = imread("AX_1.png");
image = im2double(image);
% figure
% imshow(image)

[histogram,bins] = imhist(image);
otsu_threshold = graythresh(image);
max_histogram = max(histogram);
threshold_image = imbinarize(image,otsu_threshold);

% figure;
% imhist(image);
% hold on;
% plot([otsu_threshold otsu_threshold],[0 max_histogram],'--r'); % Add a vertical red (dashed) line.
% ylim([0 0.6]);
% ylim([0 10000]);
% hold off;
% 

figure
imshow(threshold_image)

%background
R = 12;
structuring_element = strel('disk', R);

opening_image = imclose(threshold_image, structuring_element);

background_image = imcomplement(opening_image);

figure
imshow(background_image)

%skull
Rr = 8;
structuring_element = strel('disk', Rr);
sub_image = imerode(threshold_image, structuring_element);

Rrr = 3;
structuring_element_2 = strel('disk', Rrr);
sub_image_2 = conditional_dilation(sub_image, threshold_image, structuring_element_2, 16);

figure
imshow(sub_image_2)

skull_image = logical(threshold_image - sub_image_2);

figure
imshow(skull_image);

%CSF

CSF_image = threshold_image + background_image + sub_image_2; %there are places there is overlapp, thus it becomes a double in stead of logical
%see if I can fix this, maybe with some condition. 
%Also need to clean op Skull Image to get rid of all the gaps. 

figure
imshow(CSF_image)


%gray matter and white matter
white_gray_image = sub_image_2 .* image;

% figure
% imshow(white_gray_image)

[histogram1,bins1] = imhist(white_gray_image);
wg_threshold_image = imbinarize(image, 0.46);

% figure;
% imhist(white_gray_image);
% 
% figure
% imshow(wg_threshold_image)

Rr = 6;
structuring_element_wg = strel('disk', Rr);
sub_image_wg = imerode(wg_threshold_image, structuring_element_wg);

Rrr = 4;
structuring_element_2_wg = strel('disk', Rrr);
white_matter_image = conditional_dilation(sub_image_wg, wg_threshold_image, structuring_element_2_wg, 25);

figure
imshow(white_matter_image)

grey_matter_image = sub_image_2 - white_matter_image;

figure
imshow(grey_matter_image)

