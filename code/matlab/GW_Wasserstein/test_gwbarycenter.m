
% 检测GW_barycenter程序
% 以及做一个可视化

addpath('../');
addpath('../../../data/mnist_pic/2');

N=32;
distributions= cell(1,N);

%figure 
for i=1:N
    p=imread(['2 (' int2str(i) ').jpg']);
    p=im2double(p);
    p(p<0.3)=0;
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    C=pdist2(pos',pos','euclidean');
    distributions{i}= mass_distribution(2,length(omega),pos,omega,C);
end

[C,p]=solve_gwbarycenter(distributions,100);
centers= generate_sample_from_mds(C,p,2);
figure(1);
imshow(img_center);


figure(2);
plot(center.pos(1,:),center.pos(2,:),'+')


