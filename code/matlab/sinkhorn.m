function [ PI ,alpha ] = sinkhorn( Dist,lambda,a,b )
%SINKHORN ʹ��sinkhorn�������Wasserstein Distance������������Ž�
%   ��󷵻�һ������Ϊ��ɢ�����µ����Ϸֲ�(����ٶ��˾�Ϊһά�ֲ�)
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

