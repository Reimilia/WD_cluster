function [ dist ] = BADMM_dist( dim,sample1,sample2,options)
%BADMM_DIST ����BADMM�㷨ֱ�������
%dim Ϊ����ά��
%N Ϊ��������
%samples Ϊ����ΪN��cell����
%options Ϊ����׷�Ӳ���

%% Initialize components
niter = get_options(options, 'niter', 2000);
guess_cent = get_options(options,'guess', 0);
imgsize= get_options(options,'imgsize',[28,28]);
write_on= get_options(options,'write_on',0);
rho = get_options(options,'rho',0.001);
test_on= get_options(options,'test',0);

m= length(sample1.prob);
n= length(sample2.prob);

%���ڲ�����ʼ��λ��֧�����ϵ�һ�����Ϸֲ���initial guess (m*n�ľ���)
Lambda=zeros(m,n);
P1=zeros(m,n); 
P2= sample1.prob'*sample2.prob;

loop_count = 0;
v= sample2.prob; 
w= sample1.prob;
% ��һ����Ϊ�˷�ֹ��������
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
    %temp Ϊ N*m�ľ���
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

