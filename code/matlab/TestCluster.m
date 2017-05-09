%% ²âÊÔÏ¹¾ÛÀà

addpath('./ImageIO');
%addpath('../../data/mnist_pic/cluster2');
addpath('../../data/test/letter_k');
N=68;
distributions=cell(1,N);
%figure  
for i=1:N
    p=imread([int2str(i) '.png']);
    %subplot(N,1,i);
    %imshow(p)
    p=im2double(imresize(1-p,0.25));
    imgsize=size(p);
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px'/imgsize(1),py'/imgsize(2));
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');
end
options=[];
options.niter=500;
options.imgsize=imgsize;
options.test=1;
[labels,centers]=Cluster_Test(2,N,distributions,10,60,options);
labels;
for i=1:length(centers)
    img_center= image_convert(centers{i},[28,28],1);
    %figure(i);
    %imshow(img_center);
    heat_imwrite(img_center, [int2str(i), 'K_mean.png']);
end

labels
