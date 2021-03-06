close all;
clear all;
clc;
%inpainting image in tv model
img=double(imread('20.png'));
mask=imread('201.png');
fillColor = [0 255 0];
mask = mask(:,:,1)==fillColor(1) & ...
    mask(:,:,2)==fillColor(2) & mask(:,:,3)==fillColor(3);
% img=rgb2gray(img);
img = img(:,:,1) + img(:,:,3) + img(:,:,3);
img = img ./ 3;
[m n]=size(img(:,:));
mask = ~mask;
for i=1:m
    for j=1:n
        if mask(i,j)==0
            img(i,j)=0;
        end
    end
end
imshow(img,[]); %合成的需要修复的图像

lambda=0.2;
a=0.5;
imgn=img;
for l=1:3500 %迭代次数
    for i=2:m-1
        for j=2:n-1
            if mask(i,j)==0 %如果当前像素是被污染的像素，则进行处理
                
                Un=sqrt((img(i,j)-img(i-1,j))^2+((img(i-1,j-1)-img(i-1,j+1))/2)^2);%邻域像素梯度
                Ue=sqrt((img(i,j)-img(i,j+1))^2+((img(i-1,j+1)-img(i+1,j+1))/2)^2);
                Uw=sqrt((img(i,j)-img(i,j-1))^2+((img(i-1,j-1)-img(i+1,j-1))/2)^2);
                Us=sqrt((img(i,j)-img(i+1,j))^2+((img(i+1,j-1)-img(i+1,j+1))/2)^2);
                
                Wn=1/sqrt(Un^2+a^2);
                We=1/sqrt(Ue^2+a^2);
                Ww=1/sqrt(Uw^2+a^2);
                Ws=1/sqrt(Us^2+a^2);
                
                Hon=Wn/((Wn+We+Ww+Ws)+lambda);
                Hoe=We/((Wn+We+Ww+Ws)+lambda);
                How=Ww/((Wn+We+Ww+Ws)+lambda);
                Hos=Ws/((Wn+We+Ww+Ws)+lambda);
                
                Hoo=lambda/((Wn+We+Ww+Ws)+lambda);
                
                imgn(i,j)=Hon*img(i-1,j)+Hoe*img(i,j+1)+How*img(i,j-1)+Hos*img(i+1,j)+Hoo*img(i,j);
                
            end
        end
    end
    img=imgn;
    
end

figure;
imshow(img,[])