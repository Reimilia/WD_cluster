function [ centroid ] = BADMM( dim,N,samples,varargin)
%BADMM ����ʵ�ֻ���WD�Ŀ������������ɢ�ֲ�"����"������
%dim Ϊ����ά��
%N Ϊ��������
%samples Ϊ����ΪN��cell����
%options Ϊ����׷�Ӳ���

%% Initialize components
if nargin>3
    guess_cent =varargin{1};
    fprintf('Use the presumed guessing centroid for B-ADMM algorithm.\n');
else
    guess_cent=0;
end;
% ��������+����ʽд��
mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));
n= sum(mk);

sample_pos= cell2mat(cellfun(@(x)x.pos,samples,'UniformOutput',false));
sample_prob= cell2mat(cellfun(@(x)x.prob,samples,'UniformOutput',false));

% �����ѯ��Ƭ
slice_pos= [1,cumsum(mk)+1];

% ����ֲ��ĳ�ʼ��
if isa(guess_cent,'mass_distribution')==1
    m = guess_cent.sample_size;
else
    guess_cent=BADMM_initial_guess(dim,N,sample_pos,sample_prob);
    %guess_cent=samples{randi(N)};
    
    m= guess_cent.sample_size;
end



%���ڲ�����ʼ��λ��֧�����ϵ�һ�����Ϸֲ���initial guess (m*n�ľ���)
Lambda=zeros(m,n);
P1=zeros(m,n); 
for i=1:N
    P2(:,slice_pos(i):slice_pos(i+1)-1) = guess_cent.prob'* samples{i}.prob;
end

loop_count=0;
x_update_loops=10;
x= guess_cent.pos;
w= guess_cent.prob;


% ��һ����Ϊ�˷�ֹ��������
non_zero = 1e-16;
C= pdist2(x',sample_pos','squaredeuclidean');

rho = 2.*mean(mean(C));
rho

eps=1;
%figure(1);
c=jet(21);
%% iteration for B-ADMM
while (eps>=1e-4 && loop_count <= 2000)
    
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
    %temp = [];
    %temp Ϊ N*m�ľ���
    for i=1:N
        slice_tmp=P2(:,slice_pos(i):slice_pos(i+1)-1);
        slice_sum=sum(slice_tmp,2);
        %temp=cat(2,temp,slice_sum);
        weight= bsxfun(@times, 1./slice_sum', w);
        P2(:,slice_pos(i):slice_pos(i+1)-1)= bsxfun(@times,weight',slice_tmp);
    end

    %update w
    stemp= sum(P2,2);
    w= stemp'/ sum(stemp);
    
    %update Lambda
    Lambda = Lambda + rho*(P1-P2);

    
    if mod(loop_count,x_update_loops)==0
        x= sample_pos*P1'*diag(1./w)/N;
        C= pdist2(x',sample_pos','squaredeuclidean');
        rho = 2.*mean(mean(C));
    end
    % ѭ������+1

    loop_count=loop_count+1;
    %�������������
    if mod(loop_count,100)==0
        primres = norm(P1-P2,'fro')/norm(P2,'fro');
        dualres = norm(P2-last_P2,'fro')/norm(P2,'fro');
        %fprintf('\t %d %f %f %f ', loop_count, sum(C(:).*P1(:))/n,primres, dualres);
        fprintf('\n%f,%f,%f,%f', norm(P1,'fro'),norm(P2,'fro'),norm(Lambda,'fro'),norm(P1-P2,'fro'));
        %fprintf('\n');       
        eps=sqrt(dualres * primres);
        %% test plot
        if dim==2
            centroid= mass_distribution(dim,length(x),x,w,'euclidean');
            imwrite(image_convert(centroid,[28,28]), ['temp/',int2str(loop_count),'.png']);
            %plot(x(1,:),x(2,:),'+','color',c(loop_count/100+1,:));
            hold on;
        end
    end

    
end

centroid= mass_distribution(dim,length(x),x,w,'euclidean');
end

