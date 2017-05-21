function [ histogram ] = im2histogram( mat, threshold )
%IM2HISTOGRAM �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
p=im2double(mat);
if(p(1,1)==1)
    %Lazy way to judge
    p=1-p;
end
imgsize=size(p);
p(p<threshold)=0;

%�����Բ��(��ʵ���п���)
max_p= max(p(:));
min_p= min(p(:));
eps=0.05;
p(p>0)= eps+(p(p>0)-min_p)/(max_p-min_p)*(1-eps);
p=p/sum(p(:));
omega=p(p>0);
omega=omega';
[px,py]=ind2sub(size(p),find(p>0));
pos=cat(1,px'/imgsize(1),py'/imgsize(2));

% To do: ����Ķ�����û�б�Ҫ?
%means=mean(pos,2);
%pos=pos-means;
histogram=  mass_distribution(2,length(omega),pos,omega,'euclidean');

end

