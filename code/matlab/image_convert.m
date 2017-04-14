function [ img ] = image_convert( distribution, imgsize, power ,options )
%转换为图像数据
% power 表示放大倍率
pos= floor(diag(imgsize)*distribution.pos*power);
size(pos);
imgsize= imgsize*power;
img=zeros(imgsize);
cnt=ones(imgsize);


%index= sub2ind(imgsize,pos(1,:),pos(2,:));
for i=1:length(pos)
    x= pos(1,i);
    y= pos(2,i);
    if x>0 && y>0 && x<=imgsize(1) && y<=imgsize(2)
        %img(x,y)=max(img(x,y),distribution.prob(i));
        %fprintf('%d %d\n',x,y);
        %if img(x,y)>0
        %    cnt(x,y)=cnt(x,y)+1;
        %end
        img(x,y)= img(x,y)+distribution.prob(i);
    end
end
diff= length(pos)-length(img(img>0));
%img= img./cnt;
min_d = min(img(img>0));
max_d = max(img(:));

%eps=0.05;
%线性插值到 [eps,0.8]
%这样的目的只是不让最小值变成白色
%img(img>0)=eps+(img(img>0)-min_d)/(max_d-min_d)*(0.8-eps);
img=img/max_d;
img(img>0)=0.7*exp(img(img>0)-1);
%img(img<0.3)=0;
end

