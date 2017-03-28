function [sample]= generate_sample_from_mds( C,p,dim)
%   VISUALIZE_HISTOGRAM 可视化
%   dim=2,3 表示在几维空间上可视化
%   结果会写入position里面

if dim~=2 && dim~=3 
    return ;
end

coord= mdscale(C,dim);

sample=mass_distribution(dim,length(p),coord',p,C);

end

