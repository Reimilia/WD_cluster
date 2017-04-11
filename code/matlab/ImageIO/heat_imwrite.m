function [] = heat_imwrite(img,filename)
%HEAT_IMAGE_CONVERT 
map=hot(128);
%need a more decent method
N=size(map,1)-1;


img=1-img;
pic= ind2rgb(arrayfun(@(x)floor(x*N)+1,img),map);

imwrite(imresize(pic,10),filename,'png');

end

