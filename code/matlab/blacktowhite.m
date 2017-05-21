addpath('./ImageIO');
addpath('./Barycenter');
addpath('../../data/mnist_pic/2');
Data_path= 'D:\Code_data\test\';
Train_Data_path= 'D:\Code_data\train\';
l={'1','2','3','4','5','6','7','8','9','0'};
batch_size= length(l);

filename= 'label_train.txt';
train_labels= importdata([Train_Data_path '..\' filename]);

N=10000;
for i=1:N
    p=imread([Train_Data_path int2str(i-1) '.png']);
    imwrite(1-im2double(p),[Train_Data_path int2str(i-1) 'b.png']);
    %heat_imwrite(image_convert(samples{i},[28,28],1),'test.png');
    %samples{i}.pos=samples{i}.pos-mean(samples{i}.pos,2)+14;
end
