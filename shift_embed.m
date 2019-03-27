function [] = shift_embed(im_name, sec_name)
%�ú�����һ������ͼƬ���лҶȻ�֮��Ƕ�뵽��һ�Ų�ɫͼƬ�У���ͨ���Զ���ĺ�������Ƕ��ǰ��ͼƬ��MSE
%im_name���ò���Ϊ����ͼƬ���ļ���
%sec_name���ò���Ϊ�����ļ����ļ���
im = imread(im_name);%�õ�����ͼƬ��rgbģʽͼ
subplot(1,2,1);imshow(im);title('Origin');
sec = imread(sec_name);
sec_gray = rgb2gray(sec);%�õ�����ͼƬ�ĻҶ�ͼ
R = im(:,:,1);%ȡ����ͼƬ��R������
G = im(:,:,2);%ȡ����ͼƬ��G������
B = im(:,:,3);%ȡ����ͼƬ��B������
[row1, col1] = size(R);%�õ�����ͼƬ�Ĵ�С
[row2, col2] = size(sec_gray);%�õ�����ͼƬ�Ĵ�С

info_height = de2bi(row2,10,2,'right-msb'); %���Ϊ1024*1024,right-msb,���λ���ұߣ���˴��
info_width = de2bi(col2,10,2,'right-msb');  
size_info = [info_height,info_width]; %��Ŵ�С��Ϣ������

%������ͼƬ�Ĳ�ͬ��������
R_ = bitand(R,248);%ȡԭͼƬR��ĸ�5λ
shiftsecR = bitshift(sec_gray,-5);%������ͼƬ����5λ����ȡ����ͼƬ�ĸ���λ
G_ = bitand(G,248);
shiftsecG = bitshift(sec_gray,-2);
shiftsecG = bitand(shiftsecG,7);
B_ = bitand(B,252);
shiftsecB = bitand(sec_gray,3);

if(row2*col2>(row1*col1-20))  %R���ǰ20LSBλ�洢������Ϣ�Ŀ�͸���Ϣ
    fprintf('You should choose another more smaller image!\n');
    warning('Too large,the information maybe part disappear!\n');
else
    %R���ǰ20��LSBλ�洢������Ϣ�Ŀ�͸���Ϣ��ֻ��R��洢��Ϣ������G���B��Ϳ���ֱ�ӷ���
    for i = 1:20
        R_(i) = bitset(R_(i),1,size_info(i));
    end
    %store the image info in the rest of cover;
    for j=1:row2*col2
        index = j+20;
        R_(index) = bitor(R_(index),shiftsecR(j));%������ͼƬ�ĸ���λ�ŵ�����ͼƬR��ĵ�3λ
    end
    %���޸ĺ��R������ݴ���ԭͼƬ��������MSE
    im(:,:,1) = R_;
    MSE_R = CalcuMSE(R,R_);
    %������ͼƬ������λ�ŵ�����ͼƬG��ĵ�3λ
    for k=1:row2*col2
        G_(k+20) = bitor(G_(k+20),shiftsecG(k));%������ͼƬ�ĸ���λ�ŵ�����ͼƬ�ĵ�3λ
    end
    %���޸ĺ��G������ݴ���ԭͼƬ��������MSE
    im(:,:,2) = G_;
    MSE_G = CalcuMSE(G,G_);
    %������ͼƬ�ĵ�2λ�ŵ�����ͼƬB��ĵ�2λ
    for l=1:row2*col2
        B_(l+20) = bitor(B_(l+20),shiftsecB(l));%������ͼƬ�ĸ���λ�ŵ�����ͼƬ�ĵ�3λ
    end
    %���޸ĺ��B������ݴ���ԭͼƬ��������MSE
    im(:,:,3) = B_;
    MSE_B = CalcuMSE(B,B_);
    subplot(1,2,2);imshow(im);title('Stegano');
    imwrite(im,'Stegano.bmp');
    fprintf('The R channel`s MSE is %4.2f;\nThe G channel`s MSE is %4.2f;\nThe B channel`s MSE is %4.2f;\n',MSE_R,MSE_G,MSE_B);
end
end