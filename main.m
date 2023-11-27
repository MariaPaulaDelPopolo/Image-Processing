% Loading the image
filename = "...";
image= im2double(imread("Input Images/" + filename));
imshow(image);

% Background segmentation
bgrSegIm = BackgroundSegmentation(image);
imshow(bgrSegIm);
imwrite(bgrSegIm, "Output Images\" + filename + "_backgroundSegmentation");

% Skull stripping
skullStripped = SkullStripFilter(image, bgrSegIm);

% Skull segmentation
skuSegIm = SkullSegmentation(skullStripped, bgrSegIm);
imshow(skuSegIm);
imwrite(skuSegIm, "Output Images\" + filename + "_SkullSegmentation");

% CSF segmentation
csfSegIm = CSFSegmentation(image, skullStripped);
imshow(csfSegIm);
imwrite(csfSegIm, "Output Images\" + filename + "_CSFSegmentation");

% White matter segmentation
whmSegIm = WhiteMatterSegmentation(image, csfSegIm, skullStripped);
imshow(whmSegIm);
imwrite(whmSegIm, "Output Images\" + filename + "_WhiteMatterSegmentation");

% Grey matter segmentation
grmSegIm = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped);
imshow(grmSegIm);
imwrite(grmSegIm, "Output Images\" + filename + "_GreyMatterSegmentation");
