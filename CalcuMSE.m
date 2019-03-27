function mse = CalcuMSE(before, after)
%This function is to calculate the MSE of the input matrix.
%before:the image before modify;
%after: the image after modify.
mse = sum(sum((double(before)-double(after)).^2))/prod(size(before));
end