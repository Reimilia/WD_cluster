function [ dist ] = BADMM_dist( dim,sample1,sample2,options)
%BADMM_DIST 利用BADMM算法直接求距离
%dim 为样本维度
%N 为样本个数
%samples 为长度为N的cell数组
%options 为函数追加参数

%% Initialize components
niter = get_options(options, 'niter', 2000);
guess_cent = get_options(options,'guess', 0);
imgsize= get_options(options,'imgsize',[28,28]);
write_on= get_options(options,'write_on',0);
rho = get_options(options,'rho',0.001);
test_on= get_options(options,'test',0);

m= length(sample1.prob);
n= length(sample2.prob);

%用于产生初始的位于支持域上的一个联合分布的initial guess (m*n的矩阵)
Lambda=zeros(m,n);
P1=zeros(m,n); 
P2= sample1.prob'*sample2.prob;

loop_count = 0;
v= sample2.prob; 
w= sample1.prob;
% 这一项是为了防止除法错误
non_zero = 1e-20;
C= pdist2(sample1.pos',sample2.pos','squaredeuclidean');
rho=0.001;
eps=1;
%% iteration for B-ADMM
while (eps>=1e-4 && loop_count <= niter)
    
    %update 
    %%
    % $\PI_1$
    P1 = P2.* exp((C+Lambda)/(-rho)) + non_zero;
    P1 = bsxfun(@times, P1, v./sum(P1));
    %update
    %%
    
    
    % $\PI_2$
    last_P2 = P2;
    P2= P1 .* exp(Lambda/rho)+ non_zero;
    %update w
    %stemp= sum(P2,2);
    %cum=ones(m,1);
    %for i=1:N
    %    slice_tmp=P2(:,slice_pos(i):slice_pos(i+1)-1);
    %    slice_sum=sum(slice_tmp,2);
    %    cum= cum .* (slice_sum .^(1/N));    
    %end
    %last_w=w;
    %w= stemp'/ sum(stemp);
    %w_norm4(loop_count+1)=norm(w);
    %temp = [];
    %temp 为 N*m的矩阵
    slice_sum=sum(P2,2);
    weight= bsxfun(@times, 1./slice_sum', w);
    P2= bsxfun(@times,weight',P2);

    %update Lambda
    Lambda = Lambda + rho*(P1-P2);
    
    

    %pi_norm4(loop_count+1)=norm(P1-P2,'fro');
    if mod(loop_count,100)==0
        primres = norm(P1-P2,'fro')/norm(P2,'fro');
        dualres = norm(P2-last_P2,'fro')/norm(P2,'fro');
        if test_on==1
            %fprintf('\t %d %f %f %f ', loop_count, sum(C(:).*P1(:))/n,primres, dualres);
            %fprintf('\n%f,%f,%f,%f\n', norm(P1,'fro'),norm(P2,'fro'),norm(Lambda,'fro'),norm(P1-P2,'fro'));
            %fprintf('\n');       
            %fprintf('\t %d %f %f %f %f ', loop_count,rho,sum(C(:).*P1(:))/n,primres, dualres);       
        end
        eps=sqrt(dualres * primres);
        %if primres>0.5
        %    rho=rho*1.5;
        %end
        %if dualres>10*primres
        %    rho=rho/1.5;
        %end
    end  
    loop_count=loop_count+1;
    
end
dist= trace(C*P1');

end

