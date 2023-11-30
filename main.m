% Loading the image
view = "COR";
files = { view + "_1", view + "_2", view + "_3", view + "_4", view + "_5"};
for i = 1:length(files);
filename = files{i};
extension = ".png";
image= im2double(imread("Input Images/" + filename + extension));
% imshow(image);

% Background segmentation
bgrSegIm = BackgroundSegmentation(image);
figure(i);
imshow(bgrSegIm);
% imwrite(bgrSegIm, "Output Images\" + filename + "_backgroundSegmentation" + extension);

% Skull stripping
% skullStripped = SkullStripFilter(image, bgrSegIm);
% figure(i);
% imshow(skullStripped);

% % Skull segmentation
% skuSegIm = SkullSegmentation(skullStripped, bgrSegIm);
% imshow(skuSegIm);
% imwrite(skuSegIm, "Output Images\" + filename + "_SkullSegmentation" + extension);
% 
% % CSF segmentation
% csfSegIm = CSFSegmentation(image, skullStripped);
% imshow(csfSegIm);
% imwrite(csfSegIm, "Output Images\" + filename + "_CSFSegmentation" + extension);
% 
% % White matter segmentation
% whmSegIm = WhiteMatterSegmentation(image, csfSegIm, skullStripped);
% imshow(whmSegIm);
% imwrite(whmSegIm, "Output Images\" + filename + "_WhiteMatterSegmentation" + extension);
% 
% % Grey matter segmentation
% grmSegIm = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped);
% imshow(grmSegIm);
% imwrite(grmSegIm, "Output Images\" + filename + "_GreyMatterSegmentation" + extension);
end;