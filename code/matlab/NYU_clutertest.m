data_path='D:\Code_Data\pfl_pg15_code\pfl_data\';
output_train_path= 'E:\My_git_repo\NYU\train\';
output_test_path= 'E:\My_git_repo\NYU\test\';
train_file_name= 'modelNetTrain128.mat';
test_file_name= 'modelNetTest128.mat';

addpath('./ImageIO/');
addpath('./Barycenter/');
% Test NYU data set

load([data_path test_file_name]);
L= size(imageTestData,4);
imgsize=[128,128];

distributions=cell(1,100);
xx=[0,50,150,250,336,422,522,608,708,808];
j=1;
count=0;
    for k=1:5
        for i=1:20
            p=  mat2gray(imageTestData(:,:,j,xx(k)+i));
            p= 1-imresize(p,0.25);
            imgsize=size(p);
            p(p<0.05)=0;
            p=p/sum(p(:));
            omega=p(p>0);
            omega=omega';
            [px,py]=ind2sub(size(p),find(p>0));
            pos=cat(1,px'/imgsize(1),py'/imgsize(2));

            % To do: 这里的对齐有没有必要?
            %means=mean(pos,2);
            %pos=pos-means;
            count=count+1;
            distributions{count}=mass_distribution(2,length(omega),pos,omega,'euclidean');
            
        end   
    end
options=[];
options.niter=500;
options.imgsize=imgsize;
options.test=1;
[labels,centers]=Cluster_Test(2,100,distributions,5,60,options);

for i=1:length(centers)
    img_center= image_convert(centers{i},[28,28],1);
    figure(i);
    imshow(img_center);
    heat_imwrite(img_center, [int2str(i), 'Y_mean.png']);
end
%center=SGD_barycenter(2,5,distributions);
%heat=colormap(hot);
%imshow(1-img_center,'Colormap',heat);
%imshow(img_center);
%imwrite(img_center, ['mean.png' ]);
%figure(2);
%plot3(center.pos(1,:),center.pos(2,:),center.prob,'+');
fprintf('Done!');
