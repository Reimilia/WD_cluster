%% 测试求解重心的问题

addpath('../../data/mnist_pic/2');

N=32;
distributions= cell(1,N);

%figure 
for i=1:N
    p=imread(['2 (' int2str(i) ').jpg']);
    %subplot(N,1,i);
    %imshow(p)
    p=im2double(p);

    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');

end

center= BADMM(2,N,distributions);
img_center= image_convert(center,[28,28]);
figure
imshow(img_center);
imwrite(img_center, ['mean.png']);


figure
plot3(center.pos(1,:),center.pos(2,:),center.prob,'+')

%%
% 
% 
% 



