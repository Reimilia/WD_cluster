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
cnt=1;
samples= cell(1,N);
for k=2:6
subindex=find(train_labels==str2double(l{k}));

for i=1:N/5
    distribution=read_image([Train_Data_path int2str(subindex(i)-1) '.png'], 0.05);
    samples{cnt}=distribution;
    %heat_imwrite(image_convert(samples{i},[28,28],1),'test.png');
    %samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
    cnt=cnt+1;
end
end
options=[];
options.niter=500;
options.imgsize=[28,28];
%options.test=1;
cluster_num=5;
[labels,centers]=Cluster_Test(2,N,samples,cluster_num,60,options);
labels;
%save(['label',int2str(k),'_',int2str(cluster_num),'_',int2str(N)],'labels')
for i=1:length(centers)
    img_center= image_convert(centers{i},[28,28],1);
    %figure(i);
    %imshow(img_center);
    heat_imwrite(img_center, [int2str(k), '_', int2str(i),'_',int2str(cluster_num), 'Y_mean.png']);
end
total=samples;
for i=1:length(centers)
   total{length(samples)+i}=centers{i}; 
end
DN= length(total);
Dist=zeros(DN);
for i=1:length(total)
    i
    Dist(i,:)= find_dist(total{i},total,60);
end
for i=1:DN
    Dist(i,i)=0;
end
for i=1:DN
    for j=i+1:DN
        Dist(i,j)=0.5*(Dist(i,j)+Dist(j,i));
        Dist(j,i)=Dist(i,j);
    end
end
Y=mdscale(Dist,2);
index=subindex(1:N);
save(['mdsk',int2str(cluster_num),'.mat'],'Y','labels','index','Dist','N','DN');

%MDS×÷Í¼
figure(1);
hold on;
x=Y(N+1:DN,1);
y=Y(N+1:DN,2);
scatter(x,y,50,'filled');

for i=1:cluster_num
    sc=25;
    x=Y(find(labels==i),1);
    y=Y(find(labels==i),2);
    scatter(x,y,sc,'filled');
end
hold off;
