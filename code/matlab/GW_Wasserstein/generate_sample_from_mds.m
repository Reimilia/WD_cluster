function [sample]= generate_sample_from_mds( C,p,dim)
%   VISUALIZE_HISTOGRAM ���ӻ�
%   dim=2,3 ��ʾ�ڼ�ά�ռ��Ͽ��ӻ�
%   �����д��position����

if dim~=2 && dim~=3 
    return ;
end

coord= mdscale(C,dim);

sample=mass_distribution(dim,length(p),coord',p,C);

end

