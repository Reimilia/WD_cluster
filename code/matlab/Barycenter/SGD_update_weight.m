function [ weight ] = SGD_update_weight( dim,N,samples, x,w )
%SGD_UPDATE_WEIGHT Get updated of w with subgradient(dual optimal)
%   ���ô��ݶȸ���Ȩ��

eps=1;
loop_count=0;


n=length(w);

%���t0�ܹؼ�����Ϊ����numcerically stable���㷨
t0=2*log(N);

%Bregman Divergence
a1=ones(1,n)/n;
a2=a1;
a=zeros(1,n);
n
while eps>=1e-4 && loop_count<=100
    beta= (loop_count+3)/2;
    last_a=a;
    a= (1-1/beta)*a1+1/beta*a2;
    a_func= @(z)get_dual_optimal(a,z.prob,pdist2(x',z.pos','squaredeuclidean'));
    alpha=sum(reshape(cell2mat(cellfun(a_func,samples,'Uniformoutput',false)),N,n))/N;
    %pause(2);
    a2= a2 .* exp(-t0/beta*alpha);
    a2= a2/sum(a2);
    a1= (1-1/beta)*a1+1/beta*a2;
    eps= norm(last_a-a)/norm(a);
    loop_count=loop_count+1;
end

weight=a;
end


function alpha= get_dual_optimal(u,v,C)
    lambda=60/median(C(:));
    [~,alpha]=sinkhorn(C,lambda,u,v);
end

