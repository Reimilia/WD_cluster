function [ guess_centroid] = BADMM_2D_initial_guess( guess_size,Imgsize )
%BADMM_2D_INITIA_GUESS 
% 我也不知道该怎么办，只能限制在Imgsize空间的整数点上取均匀分布
w= ones(1,guess_size)/guess_size;
%w=abs(randn(1,guess_size));
%w=w/sum(w(:));
index= randperm(Imgsize(1)*Imgsize(2), guess_size);
[X,Y]=ind2sub(Imgsize,index);
x=[X/Imgsize(1);Y/Imgsize(2)];
guess_centroid=mass_distribution(2,guess_size,x,w,'euclidean');
end

