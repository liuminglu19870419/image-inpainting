close all;
clear all;
clc;

dirpath = 'C:\Users\lml\Desktop\����ͼƬ';
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
        end
    end
    mask = imgT > 20;
    
   
    img_g = img_ori(:,:,3) / 3 + img_ori(:,:,2) / 3 + img_ori(:,:,1) / 3;
    img_g = img_g(121:475, 141:569,:);
    img_ori = img_ori(121:475, 141:569,:);
    subplot(1,2,1)
    image(uint8(img_ori));
    subplot(1,2,2)   
    image(medfilt2(img_g, [5 5]));
%     [inpaintedImg,origImg,C,D] = criminisi(img, mask);
%     image(uint8(inpaintedImg));
%     filename = [int2str(k) , '.jpg'];
%     imwrite(img, filename);
end

