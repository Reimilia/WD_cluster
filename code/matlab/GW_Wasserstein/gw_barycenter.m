function [ C ] = gw_barycenter( samples, p ,alpha,~)

%Get a distance matrix for barycenter
%use KL divergence or L2 loss

N= length(samples);

%uniform average
lambda= ones(1,N)/N;
M= length(p);
%initialize C
s=0;
for i=1:N
   C=samples{i}.dist;
   s=s+mean(mean(C));
end
C=(ones(M)-eye(M))*(s/N);

epsilon= 1;
loop_count=0;

while epsilon>=1e-2 && loop_count<=100
    T=cell(1,N);
    for i=1:N
        ps= samples{i}.prob;
        Cs= samples{i}.dist;
        Ts= p'*ps;
        Ns= length(ps);
        eps=1;
        inner_loop_count=0;
        while eps>=1e-5 && inner_loop_count<=100
            cs= (C.*C) * p'* ones(1,Ns) + ones(M,1)*ps* (Cs.*Cs) -2*C*Ts*Cs';
            last_Ts=Ts;
            lambda0= alpha/mean(mean(cs));
            Ts=sinkhorn(cs, lambda0, p,ps);
            Ts=Ts';
            eps = norm(last_Ts-Ts,'fro')/norm(Ts,'fro');
            inner_loop_count= inner_loop_count+1;
        end
        T{i}=Ts;
    end
    last_C=C;
    C=zeros(M);
    for i=1:N
        C=C+ lambda(i)*T{i}*samples{i}.dist*T{i}';
    end
    C=C/(p*p'); 
    epsilon= norm(last_C-C,'fro')/norm(C,'fro');
    loop_count=loop_count+1;
end

end

