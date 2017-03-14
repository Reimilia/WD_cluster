function [ labels ] = Cluster_Test( dim,N,samples,cluster_number,~)
%CLUSTER_TEST 计算聚类
%这里有N个样本，我们要把它们分成K类

% 尝试随机初始中心点
centroids= cell(1,cluster_number);
tic
for i=1:cluster_number
    sub_index= randi([1,N],1,ceil(N/4));
    sample_pos= cell2mat(cellfun(@(x)x.pos,samples(sub_index),'UniformOutput',false));
    sample_prob= cell2mat(cellfun(@(x)x.prob,samples(sub_index),'UniformOutput',false));

    centroids{i}= Cluster_initial_guess(dim,N,sample_pos,sample_prob);
    figure(i);
    plot3(centroids{i}.pos(1,:),centroids{i}.pos(2,:),centroids{i}.prob,'+');
end
toc

clear sample_pos;
clear sample_prob;

eps= 1;
loop_count=0;
a_func= @(x)find_nearest(x,centroids);

labels=zeros(1,N);
%随便分一个label
%labels=randi([1,cluster_number],1,N);
while (eps>=0.02 && loop_count<=100)
    %Assign labels
    last_labels=labels;
    tic
    labels=cell2mat(cellfun(a_func,samples,'UniformOutput',false));
    toc
    diff=abs(last_labels-labels);
    diff=diff(diff>0);
    eps=length(diff)/N;
    
    labels
    
    %Update centroids
    for i=1:cluster_number
        sub_samples=samples(find(labels==i));
        if isempty(sub_samples)==0
            centroids{i}=BADMM(dim,length(sub_samples),sub_samples);
        end
    end
    
end


