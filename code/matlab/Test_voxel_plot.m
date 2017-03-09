function Test_voxel_plot( index,voxels,VOX_SIZE)
%TEST_VOXEL_PLOT
    figure(index); 
    [voxSizeX,voxSizeY,voxSizeZ]= size(voxels);
    hold on, grid on, axis equal;
    for j = 1 : voxSizeY
        for i = 1 : voxSizeX
            for k = 1 : voxSizeZ

                if(voxels(i,j,k) == 1)

                    X =  double(i)*VOX_SIZE;
                    Y =  double(j)*VOX_SIZE;
                    Z =  double(k)*VOX_SIZE;

                    cube_plot([X,Y,Z],VOX_SIZE,VOX_SIZE,VOX_SIZE,'g');
                end
            end
        end
     end
end

