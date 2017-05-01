function [ label ] = find_nearest(test_sample,centroids,lambda)
%FIND_NEAREST 
% 计算待测试样本和所有重心之间谁的Wasserstein距离更近
% 返回结果为标签(下标)

sample_pos=test_sample.pos;
omega= test_sample.prob;
dim= size(sample_pos,1);
N=length(centroids);
dist= zeros(1,N);

options=[];
options.niter=50;

for i=1:N
    %x=centroids{i}.pos;
    %w=centroids{i}.prob;
    %C= pdist2(sample_pos',x','squaredeuclidean');
    %lambda0= lambda/mean(mean(C));
    %T= sinkhorn(C,lambda0,omega,w);
    %dist(i)= trace(T * C);
    dist(i)= BADMM_dist(dim,test_sample,centroids{i},options);
end
[~,label]=min(dist);
end

