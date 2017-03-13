function [ label ] = find_nearest(test_sample,centroids)
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
    lambda= 60/mean(mean(C));
    T= sinkhorn(C,lambda,omega,w);
    dist(i)= trace(T * C);
end
dist
[~,label]=min(dist);
end

