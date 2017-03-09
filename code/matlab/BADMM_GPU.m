function [ centroid ] = BADMM_GPU( dim,N,samples,~)
%BADMM 用于实现基于WD的快速求解若干离散分布"重心"的问题
%dim 为样本维度
%N 为样本个数
%samples 为长度为N的cell数组
%options 为函数追加参数

%% Initialize components
if exist('options','var')~=0
    guess_cent =getoptions(options,'guess_center',0);
else
    guess_cent=0;
end;

% 匿名函数+函数式写法
mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));
n= sum(mk);

sample_pos= cell2mat(cellfun(@(x)x.pos,samples,'UniformOutput',false));
sample_prob= cell2mat(cellfun(@(x)x.prob,samples,'UniformOutput',false));

posG= gpuArray(sample_pos);
probG= gpuArray(sample_prob);
% 方便查询切片
slice_pos= [1,cumsum(mk)+1]

% 待求分布的初始化
if isa(guess_cent,'mass_distribution')==1
    m = guess_cent.sample_size;
else
    guess_cent=BADMM_initial_guess(dim,N,sample_pos,sample_prob);
    m= guess_cent.sample_size;
end



%用于产生初始的位于支持域上的一个联合分布的initial guess (m*n的矩阵)
Lambda=zeros(m,n);
P1=zeros(m,n); 
for i=1:N
    P2(:,slice_pos(i):slice_pos(i+1)-1) = 1/(m*mk(i));
end

P1G=gpuArray(P1);
P2G=gpuArray(P2);
LambdaG=gpuArray(Lambda);

loop_count = 0;
x_update_loops=10;
x= guess_cent.pos
w= guess_cent.prob


% 这一项是为了防止除法错误
non_zero = 1e-16;
C= pdist2(x',sample_pos','squaredeuclidean');
CG= gpuArray(C);

rho = 2.*mean(mean(C))/N;
rho

eps=1;


%% iteration for B-ADMM
while (eps>=1e-6 && loop_count <= 1000)
    
    %update 
    %%
    % $\PI_1$
    P1G = P2G.* exp((CG+LambdaG)/(-rho)) + non_zero;
    P1G = bsxfun(@times, P1G', sample_prob'./sum(P1G)')';
    
    %update
    %%
    % $\PI_2$
    last_P2 = gather(P2G);
    P2G= P1G .* exp(LambdaG/rho)+ non_zero;
    temp = [];
    P2= gather(P2G);
    new_P2=[];
    tic
    %temp 为 N*m的矩阵
    for i=1:N
        slice_tmp=P2(:,slice_pos(i):slice_pos(i+1)-1);
        slice_sum=sum(slice_tmp,2);
        temp=cat(2,temp,slice_sum);
        weight= bsxfun(@times, 1./slice_sum', w);
        sG=gpuArray(slice_tmp);
        wG=gpuArray(diag(weight));
        new_P2= cat(2,new_P2,gather(wG*sG));
    end
    P2G=gpuArray(P2);
    toc
    %update w
    
    tic
    stemp= sum(temp,2);
    w= stemp'/ sum(stemp);
    
    %update Lambda
    LambdaG = LambdaG + rho*(P1G-P2G);
    
    if mod(loop_count,x_update_loops)==0
        x= sample_pos*P1'*diag(1./w)/N;
        C= pdist2(x',sample_pos','squaredeuclidean');
        CG=gpuArray(C);
    end
    toc
    %计算误差并输出调试
    if mod(loop_count,100)==0
        P1=gather(P1G); P2=gather(P2G);
        primres = norm(P1-P2,'fro')/norm(P2,'fro');
        dualres = norm(P2-last_P2,'fro')/norm(P2,'fro');
        fprintf('\t %d %f %f %f ', loop_count, sum(C(:).*P1(:))/n,primres, dualres);
        fprintf('\n');       
        eps=sqrt(dualres * primres);
    end
    % 循环次数+1
    fprintf('%d ', loop_count);
    loop_count=loop_count+1;
end

centroid= mass_distribution(dim,length(x),x,w,'euclidean');
end

