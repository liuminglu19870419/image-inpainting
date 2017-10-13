close all;
clear all;
clc;

dirpath = 'C:\Users\lml\Desktop\³¬ÉùÍ¼Æ¬\8.7-8.28';
[ mFiles] = RangTraversal( dirpath, '.jpg' );

for k = 1 : length(mFiles)
%     for k = 1 : 10
    filepath = cell2mat(mFiles(k));
    filename = regexp(filepath, '[\\/]', 'split');
    filename = cell2mat(filename(end));
    img = imread(filepath);
    [x1, y1, x2, y2] = delete_border(img);
    img = double(img(y1:y2, x1:x2,:));
    img_ori = img;
%     image(uint8(img));
    
    imgT = zeros(size(img(:,:,1)));
    sz = size(img(:,:,1));
    mask = zeros(sz);
    for i = 1 : sz(1)
        for j = 1 : sz(2)
            imgT(i, j) =  max(img(i,j,:)) - min(img(i,j,:));
            if imgT(i, j) > 40
                mask(i, j) = 1;
            end
%             if abs(img(i,j,1) - img(i,j,2)) <= 2 && img(i,j,1) - img(i,j,3) > 4
%                 mask(i, j) = 1;
%             end
        end
    end
 
    
    img_t = img(:,:,2) * 2 - img(:,:,1) -img(:,:,3);
    mask = mask + double(img_t > 20);
    b = strel('disk', 1);  
    mask = imdilate(mask, b);
    mask = mask > 0;
    [x, y] = find(mask == 1);
    for j = 1 : length(x)
      img(x(j), y(j), 1) = 0;  
      img(x(j), y(j), 2) = 255;  
      img(x(j), y(j), 3) = 0;  
    end
    

    img_g = img_ori(:,:,3) / 3 + img_ori(:,:,2) / 3 + img_ori(:,:,1) / 3;
    subplot(1,2,1)
    image(uint8(img_ori));
    subplot(1,2,2)   
    filename = ['8.7-8.28/', filename];
    image(uint8(img));
%     [inpaintedImg,origImg,C,D] = criminisi(img, mask);
%     inpaintedImg(:,:,1) = medfilt2(inpaintedImg(:,:,1), [5 5]);
%     inpaintedImg(:,:,2) = medfilt2(inpaintedImg(:,:,2), [5 5]);
%     inpaintedImg(:,:,3) = medfilt2(inpaintedImg(:,:,3), [5 5]);
%     image(uint8(inpaintedImg));
    imwrite(uint8(img), filename);
end

