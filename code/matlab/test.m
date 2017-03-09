%% ≤‚ ‘æ€¿‡≥Ã–Ú

addpath('../../data/meshes/');

Box_size=25.0;
Voxel_size=1.0;

voxels= advVoxelization('sofa_test.obj',Box_size,Voxel_size);
Test_voxel_plot(1,voxels,Voxel_size)
%%
% 
% 
% 



