%net.m
function [net_out,hidden_out]= net(input_img,hidden_num,w_hidden,w_out)
%创建一个三层神经网络,隐含层有hidden_num个隐层节点
%input_img输入列向量图像
%hidden_num隐含层节点数量
%w_hidden隐层权重,行数对应着隐层节点序号，列数对应着与相应列数的输入节点与此行序号的隐层节点的权重
%w_out输出层权重
%net_out网络输出
size_img=size(input_img,1);
net_out=zeros(size_img,1);
%隐层输出
hidden_out=zeros(hidden_num,1);
for j=1:hidden_num
    t=w_hidden(j,:)*input_img;
    hidden_out(j)=sigmoid_new(w_hidden(j,:)*input_img);
end
%输出层
for i=1:size_img
    net_out(i)=sigmoid_new(w_out(i,:)*hidden_out);
end
end

function y=sigmoid_new(x)
    y=1./(1+exp(-x));
end
