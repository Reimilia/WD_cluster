%% ≤‚ ‘œπæ€¿‡

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
    pos=cat(1,px',py');
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');
end

[labels,centers]=Cluster_Test(2,N,distributions,10,60);
labels;
for i=1:length(centers)
    img_center= image_convert(centers{i},[28,28]);
    figure(i);
    imshow(img_center);
    imwrite(img_center, [int2str(i), 'X_mean.png']);
end

labels
