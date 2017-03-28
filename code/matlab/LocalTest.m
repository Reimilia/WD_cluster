%% ≤‚ ‘œπæ€¿‡

addpath('../../../MNIST_data/');
N=500;
distributions=cell(1,N);
%figure 
for i=1:N
    p=imread([int2str(i) '.jpg']);
    %subplot(N,1,i);
    %imshow(p)
    p=im2double(p);
    p(p<0.5)=0;
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');
end

[labels,centers]=Cluster_Test(2,N,distributions,20,100);
save('a.mat','labels','centers');
for i=1:length(centers)
    figure(i)
    plot3(centers{i}.pos(1,:),centers{i}.pos(2,:),centers{i}.prob,'+');
end
%system('shutdown -s');

