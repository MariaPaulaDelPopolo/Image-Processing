files = {'AX_1' 'AX_2' 'AX_3' 'AX_4' 'AX_5'};
for i = 3 %1:length(files);
% load images 
file = files{i};
image = imread(fullfile('C:\Users\ehulst\surfdrive - Hulst, E. van (Ellen)@surfdrive.surf.nl\Overig\Courses\G2 Image processing\Assignment\AssignmentTrainingImages\',[file '.png']));
image = double(image);

% filtering (not sure if necassary)  
HSIZE=1;
element = fspecial('average',HSIZE);
%image = imfilter(image,element);

% segment background 
mask_background = image > 40;
se = strel('disk', 15);
mask_background = imclose(mask_background,se); % take complement for background

% segment skull 
image2 = image.*mask_background; 
mask2 = image2 > 50;

% se = strel('disk', 1);
% test = imerode(mask2,se);
% test2 = imerode(test,se);

se = strel('disk', 1);
mask3 = imopen(mask2,se);

se = strel('disk', 1);
mask4 = imerode(mask3,se);

structure_element = strel('disk', 1);
[mask5] = conditional_dilation(mask4, mask3, structure_element, 200);

mask6=mask2-mask5;  
se = strel('disk', 1);
mask7 = imclose(mask6,se);

se = strel('disk', 3);
mask8 = imerode(mask7,se);

[mask8] = conditional_dilation(mask8, mask6, structure_element, 500);

result = mask8.*image; 

figure(i)
imagesc(mask2)
end 