function [ centroid ] = BADMM( dim,N,samples,~)
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

% 方便查询切片
slice_pos= [1,cumsum(mk)+1]

% 待求分布的初始化
if isa(guess_cent,'mass_distribution')==1
    m = guess_cent.sample_size;
else
    guess_cent=BADMM_initial_guess(dim,N,sample_pos,sample_prob);
    m= guess_cent.sample_size;
end

Lambda=zeros(m,n);

%用于产生初始的位于支持域上的一个联合分布的initial guess (m*n的矩阵)
P1=zeros(m,n); 
for i=1:N
    P2(:,slice_pos(i):slice_pos(i+1)-1) = 1/(m*mk(i));
end

loop_count = 0;
x_update_loops=10;
x= guess_cent.pos
w= guess_cent.prob


% 这一项是为了防止除法错误
non_zero = 1e-16;
C= pdist2(x',sample_pos','squaredeuclidean');

rho = 2.*mean(mean(C));

eps=1;

%% iteration for B-ADMM
while (eps>=1e-6 && loop_count <=100)
    
    P1 = P2.* exp((C+Lambda)/(-rho)) + non_zero;
    P1 = bsxfun(@times, P1', sample_prob'./sum(P1)')';
    
    
    
    last_P2 = P2;
    P2= P1 .* exp(Lambda/rho)+ non_zero;
    temp = [];
    
    %temp 为 N*m的矩阵
    for i=1:N
        slice_tmp=P2(:,slice_pos(i):slice_pos(i+1)-1);
        slice_sum=sum(slice_tmp,2);
        temp=cat(2,temp,slice_sum);
        weight= bsxfun(@times, 1./slice_sum', w);
        P2(:,slice_pos(i):slice_pos(i+1)-1)= diag(weight)*slice_tmp;
    end
    %update Lambda
    Lambda = Lambda + rho*(P1-P2);
    
    %update w
    stemp= sum(temp,2);
    w= stemp'/ sum(stemp);
    
    if mod(loop_count,x_update_loops)==0
        x= sample_pos*P1'*diag(1./w)/N;
        C= pdist2(x',sample_pos','squaredeuclidean');
    end
    
    %计算误差并输出调试
    primres = norm(P1-P2,'fro')/norm(P2,'fro');
    dualres = norm(P2-last_P2,'fro')/norm(P2,'fro');
    %fprintf('\t %d %f %f %f ', loop_count, sum(C(:).*P1(:))/n,primres, dualres);
    %fprintf('\n');       
    eps=sqrt(dualres * primres);
    
    % 循环次数+1
    loop_count=loop_count+1;
end

centroid= mass_distribution(dim,length(x),x,w,'euclidean');
end

