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
theta=0.5;

while (eps>=1e-4 && loop_count<=1000)
    last_w=w;
    %Test pic
    centroid=mass_distribution(dim,N,x,w,'euclidean');
    heat_imwrite(image_convert(centroid,[28,28],1),['temp/' int2str(loop_count) '.png']);
    w= SGD_update_weight(dim,N,samples,x,w)
    K=zeros(1,length(w));
    % update x
    for i=1:N
        C= pdist2(x',samples{i}.pos','squaredeuclidean');
        lambda= 60/mean(mean(C));
        T= sinkhorn(C,lambda,w,samples{i}.prob);
        K= K+samples{i}.pos*T;
    end
    last_x=x;
    x= (1-theta)*x+ theta/N*K*diag(1./w);
    eps=max(norm(last_x-x)/norm(x),norm(last_w-w)/norm(w));
    loop_count=loop_count+1;

end

centroid=mass_distribution(dim,N,x,w,'euclidean');

end


