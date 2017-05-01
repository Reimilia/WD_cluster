data_path='D:\Code_Data\pfl_pg15_code\pfl_data\';
output_train_path= '..\..\..\data\NYU\train\';
output_test_path= '..\..\..\data\NYU\test\';
train_file_name= 'modelNetTrain128.mat';
test_file_name= 'modelNetTest128.mat';

tic
%load([data_path train_file_name]);
%length= size(imageTrainData,4);

%for i=1:6
%   for j=1:length
%       output_name=[int2str(i) '\' int2str(j) '_' int2str(trainLabel(j)) '.png'];
%       imwrite(mat2gray(imageTrainData(:,:,i,j)), [output_train_path output_name]);
%   end
%end

load([data_path test_file_name]);
length= size(imageTestData,4);

for i=1:6
   for j=1:length
       output_name=[int2str(i) '/' int2str(j) '_' int2str(testLabel(j)) '.png'];
       imwrite(mat2gray(imageTestData(:,:,i,j)), [output_test_path,output_name]);
   end
end
toc