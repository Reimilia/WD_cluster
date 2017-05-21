%% 用于生成Wasserstein距离的程序

addpath('./ImageIO');
addpath('./Barycenter');
addpath('../../data/wdist');
Data_path= 'D:\Code_data\test\';
Train_Data_path= 'D:\Code_data\train\';

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

N=8;
samples= cell(1,N);
for i=1:N
    samples{i}=read_image([int2str(i) '.png'], 0.1);
    %samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
end
options=[];
options.niter=500;
options.test=1;
tic
dist=zeros(N);
for i=1:N
    i
    dist(i,:)= find_dist(samples{i},samples,3000);
end
toc
dist
save('dist3.mat','dist');
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


%img_center= image_convert(center,[28,28],1);

%heat=colormap(hot);
%imshow(1-img_center,'Colormap',heat);
%imshow(img_center);
%heat_imwrite(img_center, [int2str(k) '_mean_out.png' ]);
%plot3(center.pos(1,:),center.pos(2,:),center.prob,'+');

