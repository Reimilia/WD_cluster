function [ voxels ] = voxel_convert( distribution, Box_Size, options )
%VOXEL_CONVERT ת���ֲ�Ϊ����

pos= round(distribution.pos);
voxels= zeros(Box_Size);
for i=1:length(pos)
    if pos(1,i)>0 && pos(1,i)<=Box_Size(1)
        if pos(2,i)>0 && pos(2,i)<=Box_Size(2)
            if pos(3,i)>0 && pos(3,i)<=Box_Size(3)
                voxels(pos(1,i),pos(2,i),pos(3,i))=voxels(pos(1,i),pos(2,i),pos(3,i))+distribution.prob(i);
            end
        end
    end
end


end

