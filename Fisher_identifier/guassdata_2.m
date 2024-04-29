function guassdata = guassdata_2(u,sigma,num,plotpara)
%二维高斯随机样本
%u为一个行向量
%sigma为一个2*2协方差矩阵
%num为样本数量
%plotpara以何种图像画出样本点
r = mvnrnd(u,sigma,num);
plot(r(:,1),r(:,2),plotpara);
hold on
guassdata=cell(1,1);
for i=1:size(r,1)
    guassdata{1,i}=r(i,:)';
end

