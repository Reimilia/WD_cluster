%% ≤‚ ‘œπæ€¿‡

addpath('./ImageIO');
addpath('../../data/mnist_pic/cluster2');
N=200;
distributions=cell(1,N);
%figure  
for i=1:N
    p=imread([int2str(i) '.jpg']);
    %subplot(N,1,i);
    %imshow(p)
    p=im2double(p);
    p(p<0.1)=0;
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px'/28,py'/28);
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');
end
options=[];
options.niter=300;
options.imgsize=[28,28];
options.test=1;
[labels,centers]=Cluster_Test(2,N,distributions,10,60,options);
labels;
for i=1:length(centers)
    img_center= image_convert(centers{i},[28,28],1);
    figure(i);
    imshow(img_center);
    heat_imwrite(img_center, [int2str(i), 'Y_mean.png']);
end

labels
