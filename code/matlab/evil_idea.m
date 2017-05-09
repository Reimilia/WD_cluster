addpath('./ImageIO');
addpath('./Barycenter');
addpath('../../data/mnist_pic/2');
Data_path= 'D:\Code_data\test\';
Train_Data_path= 'D:\Code_data\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

N=200;
k=7;
subindex=find(train_labels==str2double(l{k}));
samples= cell(1,N);
for i=1:N
    samples{i}=read_image([Train_Data_path int2str(subindex(i)-1) '.png'], 0.1);
    %heat_imwrite(image_convert(samples{i},[28,28],1),'test.png');
    %samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
end
options=[];
options.niter=500;
options.imgsize=[28,28];
options.test=1;
cluster_num=5;
[labels,centers]=Cluster_Test(2,N,samples,5,60,options);
labels;
save(['label',int2str(k),'_',int2str(cluster_num),'_',int2str(N)],'labels')
for i=1:length(centers)
    img_center= image_convert(centers{i},[28,28],1);
    %figure(i);
    %imshow(img_center);
    heat_imwrite(img_center, [int2str(k), '_', int2str(i), 'Y_mean.png']);
end

