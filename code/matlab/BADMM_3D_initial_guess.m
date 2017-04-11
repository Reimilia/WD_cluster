function [ guess_centroid] = BADMM_3D_initial_guess( guess_size,Voxsize )
%BADMM_2D_INITIA_GUESS 
% 我也不知道该怎么办，只能限制在Imgsize空间的整数点上取均匀分布
w= ones(1,guess_size)/guess_size;
%w=rand(1,guess_size);
%w=w/sum(w(:));
index= randperm(Voxsize(1)*Voxsize(2)*Voxsize(3), guess_size);
[X,Y,Z]=ind2sub(Voxsize,index);
x=[X;Y;Z];
guess_centroid=mass_distribution(2,guess_size,x,w,'euclidean');


end

