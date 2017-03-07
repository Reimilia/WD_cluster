%% ²âÊÔ¾ÛÀà³ÌÐò

name={'h0','h1','h2','h3'};
addpath('../../data/test/small_pic_batch');

N=length(name);
distributions= cell(1,N);

for i=1:N
    p=imread([name{i} '.png']);
    p=1-im2double(rgb2gray(p));
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');

end

center= BADMM(2,N,distributions);
img_center= image_convert(center,[64,64]);
%imshow(img_center)
figure
plot3(center.pos(1,:),center.pos(2,:),center.prob,'+')




