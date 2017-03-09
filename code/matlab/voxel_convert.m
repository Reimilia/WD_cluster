function [ voxels ] = voxel_convert( distribution, Box_Size, options )
%VOXEL_CONVERT ת���ֲ�Ϊ����

pos= round(distribution.pos);
voxels= zeros(Box_Size);
for i=1:length(pos)
    voxels(pos(1,i),pos(2,i),pos(3,i))=voxels(pos(1,i),pos(2,i),pos(3,i))+distribution.prob(i);
end


end

