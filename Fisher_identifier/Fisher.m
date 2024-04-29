function [sorter_w,sorter_w0] = Fisher(database)
%逐对分类器
%--------------------------------------database输入数据库,cell类型
%--------------------------------------database{1,1+2}{1,3+2}为第一类第3个样本,样本为一个列特征向量
%--------------------------------------sorter_w---各两类之间fisher超平面法向量如{1,2}之间为1、2类分类
%-------------------------------------------------{2,4}之间为2、4类分类
%-------------------------------------------------{2,1}不存在因为{1,2}元素已经计算了
%--------------------------------------sorter_w0---各两类之间fisher超平面平移量w0
%--------------------------------------
%-------------------------------------------------
%类别数量
category_num=size(database,2);%"2"返回列数

%各类类均值向量集合 数据类型为double
m=cell(1,1);
for i=1:category_num  
%本类别的样本数量
sample_num=double(size(database{1,i},2));
%本类别 和样本向量
sigma_x=zeros(size(database{1,i}{1,1}));%每个样本维数相同
    for j=1:sample_num
        sigma_x=double(database{1,i}{1,j})+sigma_x;
    end
m{1,i}=sigma_x./sample_num;
end

%各类的类内离散度矩阵集合
S=cell(1,1);
for i=1:category_num  
%本类别的样本数量
sample_num=uint8(size(database{1,i},2));%前两位不是类
%各类的类内离散度矩阵 数据类型为double
sigma_S=zeros(size(database{1,i}{1,1},1),size(database{1,i}{1,1},1));
    for j=1:sample_num
        sigma_S=(double(database{1,i}{1,j})-m{1,i})*(double(database{1,i}{1,j})-m{1,i})'+sigma_S;
    end
S{1,i}=sigma_S;
end

%求解所有分类器
sorter_w=cell(1,1);
sorter_w0=cell(1,1);
for i=1:category_num
    for j=i+1:category_num
        %求两类的总类内离散度矩阵
        Sw=S{1,i}+S{1,j};
        Sw_Inverse=Sw^-1;
        sorter_w{i,j}=(Sw_Inverse)*(m{1,i}-m{1,j});
        sorter_w0{i,j}=-0.5*((m{1,i}+m{1,j})'*Sw_Inverse*(m{1,i}-m{1,j}))-log(double(size(database{1,i},2))./double(size(database{1,i},2)));
    end
end
end

