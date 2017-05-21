function [ labels,centroids] = Cluster_Test( dim,N,samples,cluster_number,lambda,options)
%CLUSTER_TEST 计算聚类
%这里有N个样本，我们要把它们分成K类

% 尝试随机初始中心点
samples{1}
sub_sample_number= ceil(2*N/cluster_number);
mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));
n= sum(mk);

tic
%centroids= cell(1,cluster_number);
%for i=1:cluster_number
    %sub_index= randperm(N);
    %sub_index=sub_index(1:sub_sample_number);
    %centroids{i}= BADMM(dim,sub_sample_number,samples(sub_index));
    %figure(i);
    %plot3(centroids{i}.pos(1,:),centroids{i}.pos(2,:),centroids{i}.prob,'+');
%    centroids{i}=BADMM_2D_initial_guess(ceil(n/N),[28,28]);    
%end
centroids= Cluster_initial_guess(dim,N,samples,cluster_number,lambda);

toc
eps= 1;
loop_count=0;

labels=zeros(1,N);
%随便分一个label
%labels=randi([1,cluster_number],1,N);
while (eps>=0.02 && loop_count<=50)
    %Assign labels
    last_labels=labels;
    a_func= @(x)find_nearest(x,centroids,lambda);
    tic
    labels=cell2mat(cellfun(a_func,samples,'UniformOutput',false));
    toc
    diff=abs(last_labels-labels);
    diff=diff(diff>0);
    eps=length(diff)/N    
    %Update centroids
    for i=1:cluster_number
        sub_samples=samples(find(labels==i));
        if length(sub_samples)>0
            %options.guess= centroids{i};
            centroids{i}=BADMM(dim,length(sub_samples),sub_samples,options);
        end
    end
    for i=1:cluster_number
        img_center= image_convert(centroids{i},[28,28],1);
        %imshow(img_center);
        heat_imwrite(img_center, ['temp/', int2str(i), '_', int2str(loop_count) ,'_mean.png']);
    end
    loop_count = loop_count+1;
    
end


