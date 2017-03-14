function [ guess_centroid ] = BADMM_initial_guess( dim,N,sample_pos,sample_prob,~ )
% �������λ�� (���Ч����������Ҫ�ĳ�Kmean�²��ʼ����)
% ������֪�����Ȳ²�һ���ֵ
% dimΪ����ά�ȣ�NΪ��������
% samples�ǳ���ΪN��cell�����ʾN���۲�����
% options Ϊ����ѡ��

n=size(sample_pos,2);

guess_size= ceil(n/N);
sample_mean= sample_pos * sample_prob'/ (N-dim);
z= sample_pos- repmat(sample_mean,[1,n]);
sample_covs= z*diag(sample_prob)*z'+ (1e-4)*eye(dim);
x= mvnrnd(sample_mean',sample_covs,guess_size);
w= rand(1,guess_size);
w= w/sum(w(:));
%figure;
%plot3(x(:,1),x(:,2),w','*')
guess_centroid=mass_distribution(dim,guess_size,x',w,'euclidean');

end

