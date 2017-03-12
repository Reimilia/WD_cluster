%% ²âÊÔ¾ÛÀà³ÌÐò

name={'h0','h1','h2','h3'};
%name={'k0','k1','k2','k3','k4'};
%name={'w0','w1','w2','w3','w4','w5'};
addpath('../../data/test/small_pic_batch');

N=length(name);
distributions= cell(1,N);

%figure 
for i=1:N
    p=imread([name{i} '.png']);
    %subplot(N,1,i);
    %imshow(p)
    p=1-im2double(rgb2gray(p));

    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');

end

center= BADMM(2,N,distributions);
img_center= image_convert(center,[100,100]);
figure
imshow(img_center)
imwrite(img_center, [name{i}(1) '_mean.png']);


figure
plot3(center.pos(1,:),center.pos(2,:),center.prob,'+')

%%
% 
% 
% 



