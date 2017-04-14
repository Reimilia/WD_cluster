function [ histogram ] = read_image( filename, threshold )
%READ_IMAGE ��ȡһ��ͼƬ�����ջҶ�ֵ������ֱ��ͼ

% threshold ����������ȥһЩ�����㡱
if threshold<0 || threshold>=1
    fprintf('This is no use for a single image data test!');
    return;
end


p=imread(filename);
%subplot(N,1,i);
p=im2double(p);
imgsize=size(p);
p(p<threshold)=0;

max_p= max(p(:));
min_p= min(p(:));
p(p>0)= eps+(p(p>0)-min_p)/(max_p-min_p)*(1-eps);
p=p/sum(p(:));
omega=p(p>0);
omega=omega';
[px,py]=ind2sub(size(p),find(p>0));
pos=cat(1,px'/imgsize(1),py'/imgsize(2));

% ����Ķ�����û�б�Ҫ����˵
%means=mean(pos,2);
%pos=pos-means;

histogram = mass_distribution(2,length(omega),pos,omega,'euclidean');


end

