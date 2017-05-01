function [ histogram ] = read_image( filename, threshold )
%READ_IMAGE 读取一张图片并按照灰度值来构造直方图

% threshold 变量用于舍去一些“坏点”
if threshold<0 || threshold>=1
    fprintf('This is no use for a single image data test!');
    return;
end


p=imread(filename);
%subplot(N,1,i);


histogram = im2histogram(p,threshold);


end


