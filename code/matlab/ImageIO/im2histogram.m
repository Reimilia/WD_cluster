function [ histogram ] = im2histogram( mat, threshold )
%IM2HISTOGRAM 此处显示有关此函数的摘要
%   此处显示详细说明
p=im2double(mat);
if(p(1,1)==1)
    %Lazy way to judge
    p=1-p;
end
imgsize=size(p);
p(p<threshold)=0;

%做线性差分(其实可有可无)
max_p= max(p(:));
min_p= min(p(:));
eps=0.05;
p(p>0)= eps+(p(p>0)-min_p)/(max_p-min_p)*(1-eps);
p=p/sum(p(:));
omega=p(p>0);
omega=omega';
[px,py]=ind2sub(size(p),find(p>0));
pos=cat(1,px'/imgsize(1),py'/imgsize(2));

% To do: 这里的对齐有没有必要?
%means=mean(pos,2);
%pos=pos-means;
histogram=  mass_distribution(2,length(omega),pos,omega,'euclidean');

end

