function [ centroid ] = SGD_barycenter( dim,N,samples )
%SGD_BARYCENTER SubGradient Decent method to solve barycenter problem
%   使用次梯度下降法，结合Sinkhorn Iteration去计算中心问题
%   当然这里计算的是二阶Wasserstein 问题

mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));
n= sum(mk);

guess_cent= BADMM_2D_initial_guess(ceil(n/N),[28,28]);
x= guess_cent.pos;
w= guess_cent.prob;
eps=1;
loop_count=0;
theta=0.999;
n_norm=[];
x_norm=[];
w_norm=[];
save('weightx.mat','w_norm');
while (eps>=1e-8 && loop_count<=500)
    last_w=w;
    %Test pic
    %centroid=mass_distribution(dim,N,x,w,'euclidean');
    %heat_imwrite(image_convert(centroid,[43,43],1),['../temp/' int2str(loop_count) '.png']);
    last_w=w;
    w= SGD_update_weight(dim,N,samples,x,w,loop_count);
    n_norm(loop_count+1)= norm(w);
    K=zeros(1,length(w));
    % update x
    for i=1:N
        C= pdist2(x',samples{i}.pos','squaredeuclidean');
        lambda= 60/median(C(:));
        T= sinkhorn(C,lambda,w,samples{i}.prob);
        K= K+samples{i}.pos*T;
    end
    last_x=x;
    x= (1-theta)*x+ theta/N*K*diag(1./w);
    x_norm(loop_count+1)= norm(last_x-x);
    eps=max(norm(last_x-x)/norm(x),norm(last_w-w)/norm(w))
    loop_count=loop_count+1;

end
save('weightx.mat','x_norm','n_norm','-append');
centroid=mass_distribution(dim,N,x,w,'euclidean');

end


