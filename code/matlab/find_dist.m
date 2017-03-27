function [ dist ] = find_dist(test_sample,centroids,lambda)
%FIND_NEAREST 
% �����������������������֮��˭��Wasserstein�������
% ���ؽ��Ϊ��ǩ(�±�)

sample_pos=test_sample.pos;
omega= test_sample.prob;

N=length(centroids);
dist= zeros(1,N);

for i=1:N
    x=centroids{i}.pos;
    w=centroids{i}.prob;
    C= pdist2(sample_pos',x','squaredeuclidean');
    lambda0= lambda/mean(mean(C));
    T= sinkhorn(C,lambda0,omega,w);
    dist(i)= trace(T * C);
end
end

