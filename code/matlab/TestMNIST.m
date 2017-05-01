%% 测试求解重心的问题

addpath('./ImageIO');
addpath('./Barycenter');
addpath('../../data/mnist_pic/2');
Data_path= 'D:\Code_data\test\';
Train_Data_path= 'D:\Code_data\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

N=2000;
for k=2:1:5
subindex=find(train_labels==str2double(l{k}));
samples= cell(1,N);
for i=1:N
    samples{i}=read_image([Train_Data_path int2str(subindex(i)-1) '.png'], 0.1);
    %heat_imwrite(image_convert(samples{i},[28,28],1),'test.png');
    %samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
end
%k=1;
%subindex=find(train_labels==str2double(l{k}));
%for i=1:N
%    samples{i+N}=read_image([Train_Data_path int2str(subindex(i)-1) '.png'], 0.1);
%    heat_imwrite(image_convert(samples{i},[28,28],1),'test.png');
%    samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
%end

%for i=1:N
%   samples{i}=read_image([Train_Data_path int2str(i) '.png'],0.1);
%end
%pause(2);
%center=SGD_barycenter(2,N,samples);
%dist=zeros(1,200);
%for i=1:200
%    t=read_image([Train_Data_path int2str(i-1) '.png'], 0.1);
%    C=pdist2(center.pos',t.pos','squaredeuclidean');
%    lambda= 60/median(C(:));
%    dist(i)= trace(sinkhorn(C,lambda,center.prob,t.prob)*C);
%end
options=[];
options.niter=2000;
options.test=1;
center = BADMM(2,N,samples,options);
%tic
%dist_mat= zeros(N);
%for i=1:N
%    for j=1:N
%        dist_mat(i,j)=BADMM_dist(2,samples{i},samples{j},options);
%    end

%end
%toc
%tic
%dist_mat2= zeros(N);
%for i=1:N
%    dist_mat2(i,:)=find_dist(samples{i},samples,60);
%end
%toc
%dist_mat

%dist_mat2



%center= BADMM(2,1,samples(1),options);
img_center= image_convert(center,[28,28],1);

%heat=colormap(hot);
%imshow(1-img_center,'Colormap',heat);
%imshow(img_center);
heat_imwrite(img_center, [int2str(k) '_mean.png' ]);
%plot3(center.pos(1,:),center.pos(2,:),center.prob,'+');
end

