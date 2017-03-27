function [ guess_sample ] = Cluster_initial_guess( dim,N,samples,K,lambda,~ )
%CLUSTER_INITIAL_GUESS 
% Similar as K_means++ 

guess_sample=cell(1,K);
index_list= zeros(1,K);

% Initial guess with a random sample in the data.
index_list(1)=randi([1,N],1,1);
guess_sample(1)= samples(index_list(1));

for i=2:K
	a_func= @(x)find_nearest_dist(x,guess_sample(1:i-1),lambda);
    dist=cell2mat(cellfun(a_func,samples,'UniformOutput',false));
    dist=dist/sum(dist(:));
    while 1>0
        w=cumsum(dist);
        x=rand(1,1);
        index= find(w>x,1);
        flag=0;
        for j=1:i-1
            if index==index_list(j)
                flag=1;
                break;
            end
        end
        if flag==0
            break;
        end
    end
    index_list(i)=index;
    guess_sample(i)=samples(index); 
end

index_list

end

