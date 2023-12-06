% Loading the image
view = "AX"; % Enter "AX", "COR" or "SAG";
files = { "AX_1", "AX_2", "AX_3", "AX_4", "AX_5", "SAG_1", "SAG_2", "SAG_3", "SAG_4", "SAG_5", "COR_1", "COR_2", "COR_3", "COR_4", "COR_5"};
for i = 1:length(files)
    filename = files{i};
    extension = ".png";
    image= im2double(imread("Input Images/" + filename + extension));
    % imshow(image);
    
    % Background segmentation
    bgrSegIm = BackgroundSegmentation(image);
    % figure(1);
    % subplot(3, 5, i);
    % imshow(bgrSegIm);
    % title(filename);
    % imwrite(bgrSegIm, "Output Images\" + filename + "_backgroundSegmentation" + extension);
    
    % Skull stripping
    [thrImage, skullStripped] = SkullStripFilter(image);
    % imshow(imcomplement(skullStripped) .* image);
    
    % Skull segmentation
    skuSegIm = SkullSegmentation(skullStripped, bgrSegIm);
    % figure(1);
    % subplot(3, 5, i);
    % imshow(image .* skuSegIm);
    % title(filename);
    % imwrite(skuSegIm, "Output Images\" + filename + "_SkullSegmentation" + extension);
    % 
    % % CSF segmentation
    csfSegIm = CSFSegmentation(image, skullStripped);
    % figure(1);
    % subplot(3, 5, i);
    % imshow(csfSegIm);
    % title(filename);
    % imwrite(csfSegIm, "Output Images\" + filename + "_CSFSegmentation" + extension);
    % 
    % % White matter segmentation
    whmSegIm = WhiteMatterSegmentation(image, csfSegIm, skullStripped);
    % figure(1);
    % subplot(3, 5, i);
    % imshow(whmSegIm);
    % title(filename);
    % imwrite(whmSegIm, "Output Images\" + filename + "_WhiteMatterSegmentation" + extension);
    % 
    % % Grey matter segmentation
    grmSegIm = GreyMatterSegmentation(whmSegIm ,csfSegIm, skullStripped);
    figure(1);
    subplot(3, 5, i);
    imshow(grmSegIm);
    title(filename);
    % imwrite(grmSegIm, "Output Images\" + filename + "_GreyMatterSegmentation" + extension);
end;