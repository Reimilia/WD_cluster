function [ labels,centroids] = Cluster_Test( dim,N,samples,cluster_number,lambda,~)
%CLUSTER_TEST 计算聚类
%这里有N个样本，我们要把它们分成K类

% 尝试随机初始中心点

sub_sample_number= ceil(2*N/cluster_number);
tic
%centroids= cell(1,cluster_number);
%for i=1:cluster_number
    %sub_index= randperm(N);
    %sub_index=sub_index(1:sub_sample_number);
    %centroids{i}= BADMM(dim,sub_sample_number,samples(sub_index));
    %figure(i);
    %plot3(centroids{i}.pos(1,:),centroids{i}.pos(2,:),centroids{i}.prob,'+');
%    centroids{i}=samples{randi([1,N],1,1)};
    
%end
centroids= Cluster_initial_guess(dim,N,samples,cluster_number,lambda);

toc
eps= 1;
loop_count=0;

labels=zeros(1,N);
%随便分一个label
%labels=randi([1,cluster_number],1,N);
while (eps>=1/N && loop_count<=500)
    %Assign labels
    last_labels=labels;
    a_func= @(x)find_nearest(x,centroids,lambda);
    tic
    labels=cell2mat(cellfun(a_func,samples,'UniformOutput',false));
    toc
    diff=abs(last_labels-labels);
    diff=diff(diff>0);
    eps=length(diff)/N
    labels;
    
    %Update centroids
    for i=1:cluster_number
        sub_samples=samples(find(labels==i));
        if length(sub_samples)>dim
            centroids{i}=BADMM(dim,length(sub_samples),sub_samples,centroids{i});
        end
    end
    loop_count = loop_count+1;
    
end


