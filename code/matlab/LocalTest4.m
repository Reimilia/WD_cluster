%% ²âÊÔ²ã´Î¾ÛÀà

Data_path= 'C:\Users\USER\Documents\Python Scripts\test\';
Train_Data_path= 'C:\Users\USER\Documents\Python Scripts\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

distributions= cell(1,batch_size);
centers= zeros(2,batch_size);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

for k=1:batch_size
    subindex=find(train_labels==str2double(l{k}));
    samples= cell(1,50);
    for i=1:50
        samples{i}=read_image([Train_Data_path int2str(subindex(i)-1) '.png'],0.5);
    end   
    distributions{k}= BADMM(2,50,samples);
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
    test=read_image([Data_path int2str(i-1) '.png'],0.5);
    %subplot(N,1,i);
    means=mean(test.pos,2);
    test.pos=test.pos-means;
    labels(i)= find_nearest(test,distributions,60);
    dist(i,:)= find_dist(test,distributions,60);
    if(mod(i,one_percent)==0)
        fprintf('%d percent is complete\n',round(i/one_percent));
    end
    
end

save('x.mat','dist','labels');
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




