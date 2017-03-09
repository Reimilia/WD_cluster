%% ²âÊÔ¾ÛÀà³ÌÐò

%name={'sofa1','sofa2'};
name={'m504','m507','m508','m509'};
addpath('../../data/meshes/pbs');

mat_save_path = '../../data/temp/';
addpath(mat_save_path);

N=length(name);
distributions= cell(1,N);
Box_size=24.0;
Voxel_size=1.0;

for i=1:N
    if exist([mat_save_path name{i} '.mat'],'file')==0
        %not exist, create new mat files
        voxels= advVoxelization([name{i},'.off'],Box_size,Voxel_size);
        save([mat_save_path name{i} '.mat'],'Box_size','Voxel_size','voxels');
    else
        load([mat_save_path name{i} '.mat'],'Box_size','Voxel_size','voxels');
    end
    %Turn voxels into mass distribution
    %Test_voxel_plot(i,voxels,Voxel_size);
    [px,py,pz]=ind2sub(size(voxels),find(voxels>0));
    voxels=voxels/(sum(voxels(:)));
    omega=voxels(voxels>0);
    omega=omega';
    pos= cat(1,px',py',pz');
    distributions{i}= mass_distribution(3,length(omega),pos,omega,'euclidean');
    
end

center= BADMM_GPU(3,N,distributions);
figure(1);
plot3(center.pos(1,:),center.pos(2,:),center.pos(3,:),'+')
%Convert to voxels;
voxels= voxel_convert(center,[Box_size,Box_size,Box_size]);
Test_voxel_plot(2,voxels,Voxel_size)


%Test_voxel_plot(1,voxels,2.5);

%%
% 
% 
% 



