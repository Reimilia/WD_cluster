function [ guess_centroid ] = BADMM_initial_guess( dim,N,sample_pos,sample_prob,~ )
% 随机重心位置 (如果效果不好这里要改成Kmean猜测初始解了)
% 根据已知样本先猜测一组初值
% dim为样本维度，N为样本个数
% samples是长度为N的cell数组表示N个观测样本
% options 为附加选项

n=size(sample_pos,2);

guess_size= ceil(n/N);
sample_mean= sample_pos * sample_prob'/ (N-dim);
z= sample_pos- repmat(sample_mean,[1,n]);
sample_covs= bsxfun(@times,z,sample_prob)*z'+ (1e-4)*eye(dim);
x= mvnrnd(sample_mean',sample_covs,guess_size);
%x=ones(guess_size,2)*14;
%w= rand(1,guess_size);
%w= w/sum(w(:));
w=ones(1,guess_size)/guess_size;
%w=mvnpdf(x,sample_mean',sample_covs);
%w=w';
%w=1./w;
%w=w/sum(w(:));
%figure(2);
%plot3(x(:,1),x(:,2),w','*')
guess_centroid=mass_distribution(dim,guess_size,x',w,'euclidean');

end  
    