function [ histogram ] = read_image( filename, threshold )
%READ_IMAGE ��ȡһ��ͼƬ�����ջҶ�ֵ������ֱ��ͼ

% threshold ����������ȥһЩ�����㡱
if threshold<0 || threshold>=1
    fprintf('This is no use for a single image data test!');
    return;
end


p=imread(filename);
%subplot(N,1,i);


histogram = im2histogram(p,threshold);


end


