%% ²âÊÔÏ¹¾ÛÀà

addpath('./ImageIO');
addpath('../../data/mnist_pic/cluster2');
%addpath('../../data/test/letter_k');
Data_path= 'D:\Code_data\test\';
Train_Data_path= 'D:\Code_data\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

figure(1);
hold on;
N=99;
labels=train_labels(1:N);
distributions=cell(1,N);
%figure  
count=1;
for k=2:4
for i=1:N/3
    subindex=find(train_labels==k);
    p=imread([Train_Data_path int2str(subindex(i)) '.png']);
    %subplot(N,1,i);
    %imshow(p)
    p=im2double(p);
    imgsize=size(p);
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px'/imgsize(1),py'/imgsize(2));
    %p=imcontour(p,2);
    %ll= length(p);
    %omega=ones(1,ll)/ll;
    %pos=cat(1,p(1,:)/imgsize(1),p(2,:)/imgsize(2));
    distributions{count}= mass_distribution(2,ll,pos,omega,'euclidean');
    count=count+1;
end
end
options=[];
options.niter=500;
options.imgsize=imgsize;
options.test=1;
%[labels,centers]=Cluster_Test(2,N,distributions,10,60,options);
%labels;
%for i=1:length(centers)
%    img_center= image_convert(centers{i},[28,28],1);
%    %figure(i);
%    %imshow(img_center);
%    heat_imwrite(img_center, [int2str(i), 'K_mean.png']);
%end
DN=N;
Dist=zeros(DN);
for i=1:DN
    i
    Dist(i,:)= find_dist(distributions{i},distributions,60);
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
%index=subindex(1:N);
%save(['mds2',int2str(cluster_num),'.mat'],'Y','labels','index','Dist','N','DN');

%MDS×÷Í¼
figure(2);
hold on;
%x=Y(N+1:DN,1);
%y=Y(N+1:DN,2);
%scatter(x,y,50,'filled');

for i=1:3
    sc=25;
    x=Y(N/3*(i-1)+1:N/3*i,1);
    y=Y(N/3*(i-1)+1:N/3*i,2);
    scatter(x,y,sc,'filled');
end
hold off;

