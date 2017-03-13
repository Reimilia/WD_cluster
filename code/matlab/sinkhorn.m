function [ PI ] = sinkhorn( Dist,lambda,a,b )
%SINKHORN ʹ��sinkhorn�������Wasserstein Distance������������Ž�
%   ��󷵻�һ������Ϊ��ɢ�����µ����Ϸֲ�(����ٶ��˾�Ϊһά�ֲ�)
K= exp(-lambda*Dist);
KK= bsxfun(@rdivide,K,a');
n=length(a);
a=a';
b=b';
u=ones(n,1)/n;
%sinkhorn iteration
eps=1;
loop_count=0;
while eps>=5e-3 && loop_count<=200
    last_u=u;
    u=1./(KK*(b./(K'*last_u)));
    eps= norm(last_u-u,'fro')/norm(u,'fro');
    loop_count=loop_count+1;
end
v=b./(K'*u);
PI=bsxfun(@times, v, (bsxfun(@times, K, u))');

end

