function [ guess_sample ] = Cluster_initial_guess( dim,N,sample_pos,sample_prob,~ )
%CLUSTER_INITIAL_GUESS 
% XiaJB Distribution

n=size(sample_pos,2);
guess_size= ceil(n/N);
sample_mean= randi([min(sample_pos(:))-1,max(sample_pos(:))+1],1,2);
z= sample_pos- repmat(sample_mean,[1,n]);
sample_covs= z*diag(sample_prob)*z'+ (1e-4)*eye(dim);
sample_covs=sample_covs/max(sample_covs(:))*10;

x= mvnrnd(sample_mean',sample_covs,guess_size);
w= rand(1,guess_size);
w= w/sum(w(:));
%figure;
%plot3(x(:,1),x(:,2),w','*')
guess_sample=mass_distribution(dim,guess_size,x',w,'euclidean');

end

