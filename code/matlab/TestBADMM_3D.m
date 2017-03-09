%% ²âÊÔ¾ÛÀà³ÌÐò

name={'sofa1','sofa2'};
addpath('../../data/meshes/');

N=length(name);
distributions= cell(1,N);
Box_size=25.0;
Voxel_size=1.0;

for i=1:N
    voxels= advVoxelization([name{i},'.obj'],Box_size,Voxel_size);
    %Turn voxels into mass distribution
    %Test_voxel_plot(i,voxels,Voxel_size);
    [px,py,pz]=ind2sub(size(voxels),find(voxels>0));
    voxels=voxels/(sum(voxels(:)));
    omega=voxels(voxels>0);
    omega=omega';
    pos= cat(1,px',py',pz');
    distributions{i}= mass_distribution(3,length(omega),pos,omega,'euclidean');
    
end

center= BADMM(3,N,distributions);
%Convert to voxels;

figure(N+1);
plot3(center.pos(1,:),center.pos(2,:),center.pos(3,:),'+');

%Test_voxel_plot(1,voxels,2.5);

%%
% 
% 
% 



