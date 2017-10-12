close all;
clear all;
clc;

dirpath = 'C:\Users\lml\Desktop\³¬ÉùÍ¼Æ¬';
[ mFiles] = RangTraversal( dirpath, '.jpg' );

for k = 1 : length(mFiles)
%     for k = 1 : 10
    filepath = cell2mat(mFiles(k));
    img = imread(filepath);
    img = double(img);
    img_ori = img;
    
    
    imgT = zeros(size(img(:,:,1)));
    sz = size(img(:,:,1));
    
    for i = 1 : sz(1)
        for j = 1 : sz(2)
            imgT(i, j) =  max(img(i,j,:)) - min(img(i,j,:));
            if imgT(i, j) > 20
                img(i,j,1) = 0;
                img(i,j,2) = 255;
                img(i,j,3) = 0;
            end
%             
%             if img(i,j,1) < 70 && img(i,j,1) > 50 && ...
%                     img(i,j,2) < 70 && img(i,j,2) > 50 && ...
%                     img(i,j,3) < 70 && img(i,j,3) > 50          
%                 img(i,j,1) = 100;
%                 img(i,j,2) = 0;
%                 img(i,j,3) = 0;
%             end
        end
    end
    mask = imgT > 20;
    filename = [int2str(k) , '.jpg'];
    [inpaintedImg,origImg,C,D] = criminisi(img, mask);
%     imgn(:,:,1) = tv(img_ori(:,:,1),mask);
%     imgn(:,:,2) = tv(img_ori(:,:,2),mask);
%     imgn(:,:,3) = tv(img_ori(:,:,3),mask);
    inpaintedImg = medfilt2(inpaintedImg, [5 5]);
    image(uint8(inpaintedImg));
%     imwrite(img, filename);
end

