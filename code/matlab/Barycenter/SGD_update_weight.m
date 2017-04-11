function [ weight ] = SGD_update_weight( dim,N,samples, x,w )
%SGD_UPDATE_WEIGHT Get updated of w with subgradient(dual optimal)
%   ���ô��ݶȸ���Ȩ��

eps=1;
loop_count=0;
t0=0.1;
n=length(w);

%Bregman Divergence
a1=ones(1,n)/n;
a2=a1;
a=zeros(1,n);
while eps>=1e-4 && loop_count<=1000
    loop_count=loop_count+1;
    beta= (loop_count+1)/2;
    last_a=a;
    a= (1-1/beta)*a1+1/beta*a2;
    %pause(2);
    a_func= @(z)get_dual_optimal(w,z.prob,pdist2(x',z.pos','squaredeuclidean'));
    alpha=sum(reshape(cell2mat(cellfun(a_func,samples,'Uniformoutput',false)),N,n))/N;
    %pause(2);
    a2= a2 .* exp(-t0*beta*alpha);
    
    a2= a2/sum(a2);
    a1= (1-1/beta)*a1+1/beta*a2;
    eps= norm(last_a-a)/norm(a);
end

weight=a;
end


function alpha= get_dual_optimal(u,v,C)
    lambda=60/mean(mean(C));
    [~,alpha]=sinkhorn(C,lambda,u,v);
end

