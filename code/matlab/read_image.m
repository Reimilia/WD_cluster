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
p(p<threshold)=0;

p=(exp(p)-1)*2;

p=p/sum(p(:));
omega=p(p>0);
omega=omega';
[px,py]=ind2sub(size(p),find(p>0));
pos=cat(1,px',py');

% ����Ķ�����û�б�Ҫ����˵
%means=mean(pos,2);
%pos=pos-means;

histogram = mass_distribution(2,length(omega),pos,omega,'euclidean');


end

