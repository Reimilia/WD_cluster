function [ labels ] = Cluster_Test( dim,N,samples,cluster_number,~)
%CLUSTER_TEST 计算聚类
%这里有N个样本，我们要把它们分成K类

% 尝试随机初始中心点
labels=zeros(1,N);
centroids= cells(1,cluster_number);
sample_pos= cell2mat(cellfun(@(x)x.pos,samples,'UniformOutput',false));
sample_prob= cell2mat(cellfun(@(x)x.prob,samples,'UniformOutput',false));

for i=1:cluster_number
   centriods{i}= BADMM_initial_guess(dim,N,sample_pos,sample_prob);
end

eps= 1;
loop_count=0;
while (eps>=0.02 && loop_count<=100)
    %Assign labels
    
end

clear sample_pos;
clear sample_prob;

