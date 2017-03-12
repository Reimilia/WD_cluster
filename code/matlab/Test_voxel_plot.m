function Test_voxel_plot( index,voxels,VOX_SIZE)
%TEST_VOXEL_PLOT
    figure(index); 
    [voxSizeX,voxSizeY,voxSizeZ]= size(voxels);
    
    % Regularization
    voxels= voxels/max(voxels(:));
    hold on, grid on, axis equal;
    A=colormap(parula);
    l=size(A,1);
    for j = 1 : voxSizeY
        for i = 1 : voxSizeX
            for k = 1 : voxSizeZ

                if(voxels(i,j,k) > 1e-4)

                    X =  double(i)*VOX_SIZE;
                    Y =  double(j)*VOX_SIZE;
                    Z =  double(k)*VOX_SIZE;
                    cube_plot([X,Y,Z],VOX_SIZE,VOX_SIZE,VOX_SIZE,A(ceil(voxels(i,j,k)*l),:));
                end
            end
        end
    end
    colorbar;
end

