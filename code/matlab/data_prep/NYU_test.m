data_path='D:\Code_Data\pfl_pg15_code\pfl_data\';
output_train_path= '..\..\..\data\NYU\train\';
output_test_path= '..\..\..\data\NYU\test\';
train_file_name= 'modelNetTrain128.mat';
test_file_name= 'modelNetTest128.mat';
addpath('../');
addpath('../ImageIO/');
addpath('../Barycenter/');
% Test NYU data set

load([data_path test_file_name]);
L= size(imageTestData,4);
imgsize=[128,128];

distributions=cell(1,50);
xx=[0,50,150,250,336,422,522,608,708,808];
for j=1:6
    for k=2:10
        for i=1:50
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
            distributions{i}=mass_distribution(2,length(omega),pos,omega,'euclidean');
            
        end
        options=[];
        options.niter=2000;
        options.imgsize=imgsize;
        center=BADMM(2,50,distributions,options);
        %center=SGD_barycenter(2,5,distributions);
        img_center= image_convert(center,imgsize,1);
        heat_imwrite(img_center,['../temp/',int2str(j),'_',int2str(k),'.png']);
    end
end
%heat=colormap(hot);
%imshow(1-img_center,'Colormap',heat);
%imshow(img_center);
%imwrite(img_center, ['mean.png' ]);
%figure(2);
%plot3(center.pos(1,:),center.pos(2,:),center.prob,'+');
fprintf('Done!');
