%% ≤‚ ‘≤„¥Œæ€¿‡

Data_path= '../../data/mnist_pic';
l={'0','1','2','3','4','5','6','7','8','9'};
batch_size= length(l);

for k=1:batch_size
    %figure 
    listdir=dir(['../../data/mnist_pic/' l{k},'/a*.jpg']);
    N=length(listdir)
    distributions=cell(1,N);
    for i=1:N
        p=imread(['../../data/mnist_pic/' l{k} '/a' int2str(i) '.jpg']);
        %subplot(N,1,i);
        p=im2double(p);
        p(p<0.1)=0;
        p=p/sum(p(:));
        omega=p(p>0);
        omega=omega';
        [px,py]=ind2sub(size(p),find(p>0));
        pos=cat(1,px',py');
        distributions{i}= mass_distribution(2,length(omega),pos,omega,'euclidean');
    end
    center=BADMM(2,N,distributions);
    img_center= image_convert(center,[32,32]);
    %figure
    %imshow(img_center)
    imwrite(img_center, [l{k} '_mean.png']);

end

%system('shutdown -s');

