u1 = [2,3];
sigma1 = [1 0; 0 2];
num1=100;
u2 = [7,8];
sigma2=[1 0; 0 2];
num2=120;
gusdata1=guassdata_2(u1,sigma1,num1,'r+');
gusdata2=guassdata_2(u2,sigma2,num2,'.');
gusdatabase=cell(1,1);
gusdatabase{1,1}=gusdata1;
gusdatabase{1,2}=gusdata2;
[sort_w,sort_w0]=Fisher(gusdatabase);
p=partenjudge(sort_w,sort_w0,[2,5]');
w1=sort_w{1,2}(1,1);
w2=sort_w{1,2}(2,1);
w0=sort_w0{1,2};
x=0:10;
y=(-w1*x-w0)./w2;
plot(x,y)
title("用制作的线性分类器对高斯样本进行分类")
hold off
