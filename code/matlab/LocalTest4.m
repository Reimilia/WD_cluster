%% ���Բ�ξ���

addpath('./ImageIO');
addpath('./Barycenter');
Data_path= 'D:\Code_Data\test\';
Train_Data_path= 'D:\Code_Data\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

distributions= cell(1,batch_size);
centers= zeros(2,batch_size);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

for k=1:batch_size
    subindex=find(train_labels==str2double(l{k}));
    samples= cell(1,200);
    for i=1:200
        samples{i}=read_image([Train_Data_path int2str(subindex(i)-1) '.png'],0.1);
    end   
    options=[];
    options.niter=3000;
    distributions{k}= SGD_barycenter(2,200,samples);
    centers(:,k)= mean(distributions{k}.pos,2);
    distributions{k}.pos=distributions{k}.pos-centers(:,k);
    %figure(k)
    %plot3(distributions{k}.pos(1,:),distributions{k}.pos(2,:),distributions{k}.prob,'+');
    %img_center= image_convert(distributions{k},[32,32]);
    %imwrite(img_center, [name{i}(1) '_test_mean.png']);
end
centers

listdir=dir([Data_path,'*.png']);
L= length(listdir);
one_percent= ceil(L/100);

labels=zeros(1,L);
dist=zeros(L,batch_size);

for i=1:L
    test=read_image([Data_path int2str(i-1) '.png'],0.1);
    %subplot(N,1,i);
    means=mean(test.pos,2);
    test.pos=test.pos-means;
    labels(i)= find_nearest(test,distributions,60);
    dist(i,:)= find_dist(test,distributions,60);
    if(mod(i,one_percent)==0)
        fprintf('%d percent is complete\n',round(i/one_percent));
    end
    
end

save('xx.mat','dist','labels');
filename= 'label_test.txt';
gt_labels= importdata([Train_Data_path '..\' filename]);

diff=abs(gt_labels-labels);
diff(diff==10)=0;
diff=diff(diff>0);
length(diff)
eps=length(diff)/L;
%system('shutdown -s');

D=[];
position=zeros(1,10);
for i=1:10
    subdist= dist(find(gt_labels==i-1),:);
    D=cat(1,D,subdist(1:100,:));
end
C= pdist2(D,D,'euclidean');
Y=mdscale(C,2);




