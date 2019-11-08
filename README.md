# LSB_multi_bits
- LSB 多位嵌入的算法，能成功实现将任意的灰度图片嵌入一张彩色图片中；
- 使用randperm函数生成随机的矩阵，实现LSB算法嵌入位数的随机性，增强了LSB算法的安全性；

## 文件说明

- shift_embed.m：嵌入。
- shift_extract.m：提取。
- TestForShift.m：测试脚本。

## 使用

打开MATLAB，进入该目录，执行TestForShift.m