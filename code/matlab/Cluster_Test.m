function [ labels ] = Cluster_Test( dim,N,samples,cluster_number,~)
%CLUSTER_TEST 计算聚类
%这里有N个样本，我们要把它们分成K类

% 尝试随机初始中心点
labels=zeros(1,N);
centroids= cell(1,cluster_number);
sample_pos= cell2mat(cellfun(@(x)x.pos,samples,'UniformOutput',false));
sample_prob= cell2mat(cellfun(@(x)x.prob,samples,'UniformOutput',false));


tic
for i=1:cluster_number
   centroids{i}= BADMM_initial_guess(dim,N,sample_pos,sample_prob);
   %figure(i);
   %plot3(centroids{i}.pos(1,:),centroids{i}.pos(2,:),centroids{i}.prob,'+');
end
toc

clear sample_pos;
clear sample_prob;

eps= 1;
loop_count=0;
while (eps>=0.02 && loop_count<=100)
    %Assign labels
    a_func= @(x)find_nearest(x,centroids);
    tic
    labels=cell2mat(cellfun(a_func,samples,'UniformOutput',false));
    toc
    %Update centroids
    labels
    for i=1:cluster_number
        sub_samples=samples(find(labels==i));
        if isempty(sub_samples)==0
            centroids{i}=BADMM(dim,N,sub_samples);
        end
    end
end


