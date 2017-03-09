%% ≤‚ ‘æ€¿‡≥Ã–Ú

addpath('../../data/meshes/pbs');

Box_size=25.0;
Voxel_size=1.0;

voxels= advVoxelization('m101.off',Box_size,Voxel_size);
Test_voxel_plot(1,voxels,Voxel_size)
%%
% 
% 
% 



