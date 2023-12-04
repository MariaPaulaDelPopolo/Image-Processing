%In here some tries to skull strip. 
%% poging 1 
% Skull stripping based on morphological operations. 
% Works fine, accept for brain stem 
files = {'AX_1' 'AX_2' 'AX_3' 'AX_4' 'AX_5' 'COR_1' 'COR_2' 'COR_3' 'COR_4' 'COR_5' 'SAG_1' 'SAG_2' 'SAG_3' 'SAG_4' 'SAG_5'};
for i = 1:length(files);
   file = files{i};
   image = double(imread(fullfile('C:\Users\ehulst\surfdrive - Hulst, E. van (Ellen)@surfdrive.surf.nl\Overig\Courses\G2 Image processing\Assignment\AssignmentTrainingImages\',[file '.png'])));
   [mask_background, image2] = BackgroundSegmentation(image);
   [thrImage, outputImage] = skull_segmentation3(image2,mask_background); 
  
   figure(1)
   subplot(3,5,i)
   imagesc(outputImage.*image2)
end 
%% Poging 2 
% skull stripping using active contours 
% chat gpt said this 
% does not work really well yet
files = {'AX_1' 'AX_2' 'AX_3' 'AX_4' 'AX_5' 'COR_1' 'COR_2' 'COR_3' 'COR_4' 'COR_5' 'SAG_1' 'SAG_2' 'SAG_3' 'SAG_4' 'SAG_5'};
for i = 1:length(files);
   file = files{i};
   image = double(imread(fullfile('C:\Users\ehulst\surfdrive - Hulst, E. van (Ellen)@surfdrive.surf.nl\Overig\Courses\G2 Image processing\Assignment\AssignmentTrainingImages\',[file '.png'])));
   [mask_background, image2] = BackgroundSegmentation(image);
   [outputImage] = skull_segmentation4(image2,mask_background,i);  

   figure(1)
   subplot(3,5,i)
   imagesc(outputImage)
end 
 