%% 测试求解重心的问题

addpath('./ImageIO');
addpath('./Barycenter');
addpath('../../data/mnist_pic/2');
Data_path= 'C:\Users\USER\Documents\Python Scripts\test\';
Train_Data_path= 'C:\Users\USER\Documents\Python Scripts\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

N=500;
k=8;
subindex=find(train_labels==str2double(l{k}));
samples= cell(1,N);
for i=1:N
    samples{i}=read_image([Train_Data_path int2str(subindex(i)-1) '.png'], 0.1);
    %samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
end   
%for i=1:N
%    samples{i}=read_image([Train_Data_path int2str(i) '.png'],0.1);
%end

center=SGD_barycenter(2,N,samples);
%center= BADMM(2,N,samples);
img_center= image_convert(center,[28,28],1);
heat=colormap(hot);
imshow(1-img_center,'Colormap',heat);
%imshow(img_center);
%imwrite(img_center, ['mean.png']);
plot3(center.pos(1,:),center.pos(2,:),center.prob,'+');


