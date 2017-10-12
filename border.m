close all;
clear all;
clc;

dirpath = 'C:\Users\think\Desktop\³¬ÉùÍ¼Æ¬\8.7-8.28';
[ mFiles] = RangTraversal( dirpath, '.jpg' );
for k = 1 : length(mFiles)
    img = imread(cell2mat(mFiles(k)));
    img = double(img);
    img_g = img(:,:,1) + img(:,:,2) + img(:,:,3);
    img_g = img_g / 3;
    sz = size(img_g);
    paddingh = round(sz(1) * 0.1);
    paddingw = round(sz(2) * 0.1);
    img_g = img_g(paddingh:end,paddingw:end - paddingw);
    
    e = edge(img_g, 'canny');
    [x1, y1, x2, y2] = vot_edge(e, sz(1) * 0.25);
    subplot(1,2,1)
    image(e * 10)
    subplot(1,2,2)
    image(img_g(y1:y2, x1:x2));
end

function [x1, y1, x2, y2] = vot_edge(edge, padding)
sz = size(edge);
x1_vote = zeros(1, sz(2));
for i = 1 : sz(1)
    v = find(edge(i, : ) ~= 0);
    if isempty(v) || min(v) > padding
        continue
    end
    x1_vote(min(v)) = x1_vote(min(v)) + 1;
end

[index, x1] = max(x1_vote);
x2_vote = zeros(1, sz(2));
for i = 1 : sz(1)
    v = find(edge(i, : ) ~= 0);
    if isempty(v) || max(v) < sz(2) - padding
        continue
    end
    x2_vote(max(v)) = x2_vote(max(v)) + 1;
end
[index, x2] = max(x2_vote);

y1_vote = zeros(1, sz(1));
for i = 1 : sz(2)
    v = find(edge(:, i ) ~= 0);
    if isempty(v) || min(v) > padding
        continue
    end
    y1_vote(min(v)) = y1_vote(min(v)) + 1;
end
[index, y1] = max(y1_vote);

y2_vote = zeros(1, sz(1));
for i = 1 : sz(2)
    v = find(edge(:, i ) ~= 0);
    if isempty(v) || max(v) < sz(1) - padding
        continue
    end
    y2_vote(max(v)) = y2_vote(max(v)) + 1;
end
[index, y2] = max(y2_vote);
end
