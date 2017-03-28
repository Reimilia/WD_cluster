%% ≤‚ ‘≤„¥Œæ€¿‡

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
    samples= cell(1,50);
    for i=1:100
        p=imread([Train_Data_path int2str(subindex(i*10)-1) '.png']);
        %subplot(N,1,i);
        p=im2double(p);
        p(p<0.3)=0;
        p=p/sum(p(:));
        omega=p(p>0);
        omega=omega';
        [px,py]=ind2sub(size(p),find(p>0));
        pos=cat(1,px',py');
        %center=mean(pos,2);
        %pos=pos-center;
        samples{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');
    end   
    distributions{k}= BADMM(2,100,samples);
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
    p=imread([Data_path int2str(i-1) '.png']);
    %subplot(N,1,i);
    p=im2double(p);
    p(p<0.3)=0;
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    means=mean(pos,2);
    pos=pos-means;
    test= mass_distribution(2,length(omega),pos,omega,'euclidean');
    labels(i)= find_nearest(test,distributions,100);
    dist(i,:)= find_dist(test,distributions,100);
    if(mod(i,one_percent)==0)
        fprintf('%d percent is complete\n',round(i/one_percent));
    end
    
end

save('x.mat','dist','labels');
filename= 'label_test.txt';
gt_labels= importdata([Data_path '..\' filename]);

diff=abs(gt_labels-labels);
diff(diff==10)=0;
diff=diff(diff>0);
length(diff)
eps=length(diff)/L;
%system('shutdown -s');

