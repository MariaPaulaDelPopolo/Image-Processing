files = {'AX_1' 'AX_2' 'AX_3' 'AX_4' 'AX_5'};
for i = 1:length(files);
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
mask2 = image2 > 80 & image2 <240;
se = strel('disk', 1);
mask3 = imclose(mask2,se)

% gradient_image = imgradient(image2);
% test = gradient_image > 350
% mask2(test)==0;

se = strel('disk', 8);
mask4 = imerode(mask3, se); 

structure_element = strel('disk', 1,4)
[mask5] = conditional_dilation2(mask4, mask3, structure_element,40)

test = imfill(mask5,"holes"); 
se = strel('disk', 2);
test2 = imopen(test,se)

result = mask2-test2

figure(i)
imagesc(image2)
end 