function [ Dist,histogram ] = solve_gwbarycenter( samples , alpha )
%INITIAL_GWBARYCENTER 此处显示有关此函数的摘要
%   此处显示详细说明

mk = cell2mat(cellfun(@(x)x.sample_size,samples,'UniformOutput',false));

N=ceil(sum(mk)/length(samples));

% Uniform value
histogram= ones(1,N)/N;
Dist= gw_barycenter(samples,histogram,alpha);


end

