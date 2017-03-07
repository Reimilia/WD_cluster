function [ img ] = image_convert( distribution, imgsize, options )
%转换为图像数据
pos= round(distribution.pos);
size(pos);
img=zeros(imgsize);
index= sub2ind(imgsize,pos(1,:),pos(2,:));
img(index)=distribution.prob;
img= mat2gray(1-img);
end

