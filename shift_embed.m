function [] = shift_embed(im_name, sec_name)
%该函数把一张秘密图片进行灰度化之后嵌入到另一张彩色图片中，并通过自定义的函数计算嵌入前后图片的MSE
%im_name：该参数为载体图片的文件名
%sec_name：该参数为秘密文件的文件名
im = imread(im_name);%得到载体图片的rgb模式图
subplot(1,2,1);imshow(im);title('Origin');
sec = imread(sec_name);
sec_gray = rgb2gray(sec);%得到秘密图片的灰度图
R = im(:,:,1);%取载体图片的R层数据
G = im(:,:,2);%取载体图片的G层数据
B = im(:,:,3);%取载体图片的B层数据
[row1, col1] = size(R);%得到载体图片的大小
[row2, col2] = size(sec_gray);%得到秘密图片的大小

info_height = de2bi(row2,10,2,'right-msb'); %最大为1024*1024,right-msb,最高位在右边，大端存放
info_width = de2bi(col2,10,2,'right-msb');  
size_info = [info_height,info_width]; %存放大小信息的数组

%对载体图片的不同层做处理
R_ = bitand(R,248);%取原图片R层的高5位
shiftsecR = bitshift(sec_gray,-5);%将秘密图片右移5位，即取秘密图片的高三位
G_ = bitand(G,248);
shiftsecG = bitshift(sec_gray,-2);
shiftsecG = bitand(shiftsecG,7);
B_ = bitand(B,252);
shiftsecB = bitand(sec_gray,3);

if(row2*col2>(row1*col1-20))  %R层的前20LSB位存储秘密信息的宽和高信息
    fprintf('You should choose another more smaller image!\n');
    warning('Too large,the information maybe part disappear!\n');
else
    %R层的前20个LSB位存储秘密信息的宽和高信息，只有R层存储信息，后面G层和B层就可以直接放了
    for i = 1:20
        R_(i) = bitset(R_(i),1,size_info(i));
    end
    %store the image info in the rest of cover;
    for j=1:row2*col2
        index = j+20;
        R_(index) = bitor(R_(index),shiftsecR(j));%将秘密图片的高三位放到载体图片R层的低3位
    end
    %将修改后的R层的数据存入原图片，并计算MSE
    im(:,:,1) = R_;
    MSE_R = CalcuMSE(R,R_);
    %将秘密图片的中三位放到载体图片G层的低3位
    for k=1:row2*col2
        G_(k+20) = bitor(G_(k+20),shiftsecG(k));%将秘密图片的高三位放到载体图片的低3位
    end
    %将修改后的G层的数据存入原图片，并计算MSE
    im(:,:,2) = G_;
    MSE_G = CalcuMSE(G,G_);
    %将秘密图片的低2位放到载体图片B层的低2位
    for l=1:row2*col2
        B_(l+20) = bitor(B_(l+20),shiftsecB(l));%将秘密图片的高三位放到载体图片的低3位
    end
    %将修改后的B层的数据存入原图片，并计算MSE
    im(:,:,3) = B_;
    MSE_B = CalcuMSE(B,B_);
    subplot(1,2,2);imshow(im);title('Stegano');
    imwrite(im,'Stegano.bmp');
    fprintf('The R channel`s MSE is %4.2f;\nThe G channel`s MSE is %4.2f;\nThe B channel`s MSE is %4.2f;\n',MSE_R,MSE_G,MSE_B);
end
end