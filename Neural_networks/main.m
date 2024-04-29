I=imread("Lena.bmp");   %512*512
I_row=size(I,1);
I_col=size(I,2);
subplot(1,2,1)
imshow(I)
title("原输入图像")
split_step=8;
input_img=imgsplit(I,split_step);
%hidden_num隐含层节点数量
%eta学习步长
%error_net网络规定均方误差
%itera_num最多允许迭代次数
hidden_num=32;
eta=0.01;
error_net=0.02;
itera_num=10000;
y=train(input_img,hidden_num,eta,error_net,itera_num);
re_img=zeros(size(I));
re_img1=cell(size(y));
y_row=size(y,1);
y_col=size(y,2);
for i=1:y_row
    for j=1:y_col
        re_img1{i,j}=reshape(y{i,j}.*255,[split_step,split_step]);
    end
end
for i=1:split_step:I_row
    for j=1:split_step:I_col
        re_img(i:i+split_step-1,j:j+split_step-1)=re_img1{floor(i/split_step)+1,floor(j/split_step)+1};
    end
end
subplot(1,2,2)
imshow(uint8(re_img));
title(['三层神经网络输出,迭代精度:',num2str(error_net),'迭代步长:',num2str(eta)]);



