function [ centroid ] = SGD_barycenter( dim,N,samples )
%SGD_BARYCENTER SubGradient Decent method to solve barycenter problem
%   ʹ�ô��ݶ��½��������Sinkhorn Iterationȥ������������
%   ��Ȼ���������Ƕ���Wasserstein ����

mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));
n= sum(mk);

guess_cent= BADMM_2D_initial_guess(ceil(1.5*n/N),[64,64]);
x= guess_cent.pos;
w= guess_cent.prob;
eps=1;
loop_count=0;
theta=0.3;

while (eps>=5e-4 && loop_count<=100)
    last_w=w;
    %Test pic
    centroid=mass_distribution(dim,N,x,w,'euclidean');
    heat_imwrite(image_convert(centroid,[28,28],1),['temp/' int2str(loop_count) '.png']);
    last_w=w;
    w= SGD_update_weight(dim,N,samples,x,w);
    norm(last_w-w)
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
    eps=max(norm(last_x-x)/norm(x),norm(last_w-w)/norm(w))
    loop_count=loop_count+1;

end

centroid=mass_distribution(dim,N,x,w,'euclidean');

end

