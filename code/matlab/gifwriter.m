
path='./temp';

filename='test.gif';

for i=1:100
    str=sprintf('temp\\%d.png',i);
    Img=imread(str);
    [I,map]=rgb2ind(Img,256);
    k=i-0;
    if k==1
        imwrite(I,map,filename,'gif','Loopcount',inf,...
            'DelayTime',0.1);%loopcount只是在i==1的时候才有用
    else
        imwrite(I,map,filename,'gif','WriteMode','append',...
            'DelayTime',0.1);
    end
end
for i=200:100:5000
    str=sprintf('temp\\%d.png',i);
    Img=imread(str);
    [I,map]=rgb2ind(Img,256);
    imwrite(I,map,filename,'gif','WriteMode','append',...
            'DelayTime',0.1);
end
clc;
close all;