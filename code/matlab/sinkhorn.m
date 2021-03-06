function [ PI ,alpha ] = sinkhorn( Dist,lambda,a,b )
%SINKHORN 使用sinkhorn迭代求解Wasserstein Distance问题的正则化最优解
%   最后返回一个矩阵，为离散概率下的联合分布(这里假定了均为一维分布)
K= exp(-lambda*Dist);
n=length(a);
a=a';
b=b';
u=ones(n,1)/n;
%sinkhorn iteration
eps=1;
loop_count=0;
while eps>=1e-4 && loop_count<=2000
    last_u=u;
    v=b./(K'*u);
    u=a./(K*v);
    eps= norm(last_u-u,'fro')/norm(u,'fro');
    loop_count=loop_count+1;
end

%dual solution
alpha= -log(u)'/lambda+sum(log(u))/lambda/n*ones(1,n);

PI=bsxfun(@times, v, (bsxfun(@times, K, u))');

end

