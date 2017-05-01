function [ centroid ] = BADMM( dim,N,samples,options)
%BADMM 用于实现基于WD的快速求解若干离散分布"重心"的问题
%dim 为样本维度
%N 为样本个数
%samples 为长度为N的cell数组
%options 为函数追加参数

%% Initialize components
niter = get_options(options, 'niter', 2000);
guess_cent = get_options(options,'guess', 0);
imgsize= get_options(options,'imgsize',[28,28]);
write_on= get_options(options,'write_on',0);
test_on= get_options(options,'test',0);

% 匿名函数+函数式写法
mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));
n= sum(mk);

sample_pos= cell2mat(cellfun(@(x)x.pos,samples,'UniformOutput',false));
sample_prob= cell2mat(cellfun(@(x)x.prob,samples,'UniformOutput',false));
size(sample_pos)
% 方便查询切片
slice_pos= [1,cumsum(mk)+1];

% 待求分布的初始化
if isa(guess_cent,'mass_distribution')==1
    m = guess_cent.sample_size;
else
    % due to memory limitation
    % it is not wise to generate random initial data with all points.
    %if(N<=1000)
    %  guess_cent=BADMM_initial_guess(dim,N,sample_pos,sample_prob);
    %else
    %  sample_index= randi(N,[1,1000]);
    %  k_sample_pos= cell2mat(cellfun(@(x)x.pos,samples(sample_index),'UniformOutput',false));
    %  k_sample_prob= cell2mat(cellfun(@(x)x.prob,samples(sample_index),'UniformOutput',false));
    %  guess_cent=BADMM_initial_guess(dim,1000,k_sample_pos,k_sample_prob);
    %  clear k_sample_pos;
    % clear k_sample_prob;
    %end
    guess_size= ceil(n/N);
    guess_cent= BADMM_2D_initial_guess(guess_size,imgsize);
    m= guess_cent.sample_size;
end



%用于产生初始的位于支持域上的一个联合分布的initial guess (m*n的矩阵)
Lambda=zeros(m,n);
P1=zeros(m,n); 
P2= guess_cent.prob'*sample_prob;
sum(sample_prob)

loop_count = 0;
x_update_loops=10;
x= guess_cent.pos;
w= guess_cent.prob;
% 这一项是为了防止除法错误
non_zero = 1e-20;
C= pdist2(x',sample_pos','squaredeuclidean');
rho=0;
for i=1:N
    rho=rho+2*mean(mean(C(:,slice_pos(i):slice_pos(i+1)-1)));
end
rho=rho/N;
rho
eps=1;
w_norm4 = zeros(1,niter);
x_norm4 = zeros(1,niter);
pi_norm4= zeros(1,niter);
%% iteration for B-ADMM
while (eps>=1e-4 && loop_count <= niter)
    
    %update 
    %%
    % $\PI_1$
    P1 = P2.* exp((C+Lambda)/(-rho)) + non_zero;
    P1 = bsxfun(@times, P1, sample_prob./sum(P1));
    %update
    %%
    
    
    % $\PI_2$
    last_P2 = P2;
    P2= P1 .* exp(Lambda/rho)+ non_zero;
    %update w
    stemp= sum(P2,2);
    %cum=ones(m,1);
    %for i=1:N
    %%    slice_tmp=P2(:,slice_pos(i):slice_pos(i+1)-1);
    %    slice_sum=sum(slice_tmp,2);
    %    cum= cum .* (slice_sum .^(1/N));    
    %end
    last_w=w;
    w= stemp'/ sum(stemp);
    w_norm4(loop_count+1)=norm(w);
    %temp = [];
    %temp 为 N*m的矩阵
    for i=1:N
        slice_tmp=P2(:,slice_pos(i):slice_pos(i+1)-1);
        slice_sum=sum(slice_tmp,2);
        %temp=cat(2,temp,slice_sum);
        weight= bsxfun(@times, 1./slice_sum', w);
        P2(:,slice_pos(i):slice_pos(i+1)-1)= bsxfun(@times,weight',slice_tmp);
    end


    %update Lambda
    Lambda = Lambda + rho*(P1-P2);
    
    

    %pi_norm4(loop_count+1)=norm(P1-P2,'fro');
    if mod(loop_count,100)==0
        primres = norm(P1-P2,'fro')/norm(P2,'fro');
        dualres = norm(P2-last_P2,'fro')/norm(P2,'fro');
        
        %fprintf('\t %d %f %f %f ', loop_count, sum(C(:).*P1(:))/n,primres, dualres);
        if test_on==1
            fprintf('\n%f,%f,%f,%f\n', norm(P1,'fro'),norm(P2,'fro'),norm(Lambda,'fro'),norm(P1-P2,'fro'));
            %fprintf('\n');       
            fprintf('\t %d %f %f %f %f ', loop_count,rho,sum(C(:).*P1(:))/n,primres, dualres);       
        end
        eps=sqrt(dualres * primres);
        %if primres>0.5
        %    rho=rho*1.5;
        %end
        %if dualres>10*primres
        %    rho=rho/1.5;
        %end
       %% test plot
        if dim==2 && write_on==1
            centroid= mass_distribution(dim,length(x),x,w,'euclidean');
            heat_imwrite(image_convert(centroid,imgsize,1),['../temp/',int2str(loop_count),'.png']);
            %plot(x(1,:),x(2,:),'+','color',c(loop_count/100+1,:));
            %hold on;
        end

    end  
    if mod(loop_count,x_update_loops)==0
        last_x= x;
        x= sample_pos*P1'*diag(1./w)/N;
        %x_norm4(loop_count)= norm(x-last_x);
        C= pdist2(x',sample_pos','squaredeuclidean');
       %% test plot
        if dim==2 && loop_count<=100 && write_on==1
           centroid= mass_distribution(dim,length(x),x,w,'euclidean');
           heat_imwrite(image_convert(centroid,imgsize,1),['../temp/',int2str(loop_count),'.png']);
           %plot(x(1,:),x(2,:),'+','color',c(loop_count/100+1,:));
           %hold on;
        end
    end
    loop_count=loop_count+1;
    
    
end
centroid= mass_distribution(dim,length(x),x,w,'euclidean');
save('weight.mat','w_norm4','x_norm4','pi_norm4','-append');
end

