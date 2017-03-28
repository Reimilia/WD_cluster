%% ≤‚ ‘≤„¥Œæ€¿‡

Data_path= 'C:\Users\USER\Documents\Python Scripts\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

distributions= cell(1,batch_size);
for k=1:batch_size
    p=imread([l{k} '_mean.png']);
    %subplot(N,1,i);
    p=im2double(p);
    p(p<0.1)=0;
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    distributions{k}= mass_distribution(2,length(omega),pos,omega,'euclidean');
end

listdir=dir([Data_path,'*.png']);
L= length(listdir)
one_percent= ceil(L/100);

labels=zeros(1,L);
dist=zeros(L,10);

for i=1:L
    p=imread([Data_path listdir(i).name]);
    %subplot(N,1,i);
    p=im2double(p);
    p(p<0.5)=0;
    p=p/sum(p(:));
    omega=p(p>0);
    omega=omega';
    [px,py]=ind2sub(size(p),find(p>0));
    pos=cat(1,px',py');
    test= mass_distribution(2,length(omega),pos,omega,'euclidean');
    labels(i)= find_nearest(test,distributions,100);
    dist(i,:)= find_dist(test,distributions,100);
    if(mod(i,one_percent)==0)
        fprintf('%d percent is complete\n',round(i/one_percent));
    end
    
end

save('x.mat','labels','dist');
system('shutdown -s');

