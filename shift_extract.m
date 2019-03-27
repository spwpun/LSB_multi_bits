function [] = shift_extract(steg_im)
%该函数是从一张嵌入了秘密图片的彩色图片中提取出秘密图片的过程
%steg_im:该参数为彩色图片放入文件名或者路径.
steg = imread(steg_im);
R = steg(:,:,1);
G = steg(:,:,2);
B = steg(:,:,3);
%预设置秘密图片的高与宽，并从R层提取出图片的高和宽
height = zeros(1,10);
width = zeros(1,10);
%提取秘密图片的高
for h = 1:10
    height(h) = bitget(R(h),1);
end
%提取出秘密图片的宽
for w = 11:20
    width(w-10) = bitget(R(w),1);
end
%转成十进制
height = bi2de(height);
width = bi2de(width);
fprintf('%d*%d\n',height,width);
%设置秘密图片的高和宽
R_ = zeros(height,width);
G_ = zeros(height,width);
B_ = zeros(height,width);
%提取R层的秘密信息
for i = 1:height*width
    R_(i) = bitand(R(i+20),7);%得到R层的低三位
end
%提取G层的秘密信息
for j = 1:height*width
    G_(j) = bitand(G(j),7);%得到G层的低三位
end
%提取R层的秘密信息
for k = 1:height*width
    B_(k) = bitand(B(k),3);%得到B层的低二位
end
R_ = bitshift(R_,5);% 将R层的3位数据移动到高3位
G_ = bitshift(G_,2);% 将G层的数据左移两位移动到中间3位
sec = bitor(R_,G_);% 将R层和G层的数据结合在一起
sec = bitor(sec,B_);
sec = uint8(sec);%将数据类型转为uint8，不然会显示不出来
figure;imshow(sec);title('Secret-Image');
end