function [ img ] = image_convert( distribution, imgsize, power ,options )
%转换为图像数据
% power 表示放大倍率
pos= ceil(distribution.pos*power);
size(pos);
imgsize= imgsize*power;
img=zeros(imgsize);


%index= sub2ind(imgsize,pos(1,:),pos(2,:));
for i=1:length(pos)
    x= pos(1,i);
    y= pos(2,i);
    if x>0 && y>0 && x<=imgsize(1) && y<=imgsize(2)
        img(x,y)=max(img(x,y),distribution.prob(i));
    end
end
img=img/max(img(:));
%img(img<0.3)=0;
img= mat2gray(img);
end

