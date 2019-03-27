function [] = shift_extract(steg_im)
%�ú����Ǵ�һ��Ƕ��������ͼƬ�Ĳ�ɫͼƬ����ȡ������ͼƬ�Ĺ���
%steg_im:�ò���Ϊ��ɫͼƬ�����ļ�������·��.
steg = imread(steg_im);
R = steg(:,:,1);
G = steg(:,:,2);
B = steg(:,:,3);
%Ԥ��������ͼƬ�ĸ��������R����ȡ��ͼƬ�ĸߺͿ�
height = zeros(1,10);
width = zeros(1,10);
%��ȡ����ͼƬ�ĸ�
for h = 1:10
    height(h) = bitget(R(h),1);
end
%��ȡ������ͼƬ�Ŀ�
for w = 11:20
    width(w-10) = bitget(R(w),1);
end
%ת��ʮ����
height = bi2de(height);
width = bi2de(width);
fprintf('%d*%d\n',height,width);
%��������ͼƬ�ĸߺͿ�
R_ = zeros(height,width);
G_ = zeros(height,width);
B_ = zeros(height,width);
%��ȡR���������Ϣ
for i = 1:height*width
    R_(i) = bitand(R(i+20),7);%�õ�R��ĵ���λ
end
%��ȡG���������Ϣ
for j = 1:height*width
    G_(j) = bitand(G(j),7);%�õ�G��ĵ���λ
end
%��ȡR���������Ϣ
for k = 1:height*width
    B_(k) = bitand(B(k),3);%�õ�B��ĵͶ�λ
end
R_ = bitshift(R_,5);% ��R���3λ�����ƶ�����3λ
G_ = bitshift(G_,2);% ��G�������������λ�ƶ����м�3λ
sec = bitor(R_,G_);% ��R���G������ݽ����һ��
sec = bitor(sec,B_);
sec = uint8(sec);%����������תΪuint8����Ȼ����ʾ������
figure;imshow(sec);title('Secret-Image');
end