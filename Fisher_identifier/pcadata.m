function [low_dimen,eigdatabase,u] = pcadata(database,dimension)
%将d维特征向量组成的数据库压缩维dimension维特征向量组成的数据库
%database输入d维数据库
%dimension压缩后的维度
%low_dimen压缩后的规范正交基向量组
%eigdatabase返回的dimension维特征向量数据库存储图像在dimension维度下的投影
%u样本集均值向量
%dimension要降维的维度大小,dimension小于等于category_num

%类别数量
category_num=size(database,2);%"2"返回列数



%求所有数据的中心向量
sigma_x=zeros(size(database{1,1}{1,1}));%每个样本维数相同
%总样本个数
all_num=0;
for i=1:category_num  
%本类别的样本数量
sample_num=double(size(database{1,i},2));
%总样本个数累加
all_num=sample_num+all_num;
%本类别 和样本向量
    for j=1:sample_num
        sigma_x=double(database{1,i}{1,j})+sigma_x;
    end
end
u=sigma_x./all_num;

if(all_num<dimension)
    fprintf('pcadata():dimension > category_num!')
    return
end

%求所有去均值样本构成的矩阵
X=zeros(size(database{1,1}{1,1},1),all_num);
sample_cnt=0;   %计数变量,目的是把所有样本整合到一个大矩阵中
for i=1:category_num
%本类别的样本数量
sample_num=double(size(database{1,i},2));
    for j=1:sample_num
        X(:,sample_cnt+j)=double(database{1,i}{1,j})-u;
    end
sample_cnt=sample_num+sample_cnt;
end

%求协方差矩阵的特征值和特征向量并排序
XX=X'*X;
[eigvec,eigval]=sorted(XX,'descend');

%取出前dimension个特征向量和相应的特征值并对特征向量进行归一化《模式识别》p221 (10-50)
low_dimen=zeros(size(database{1,1}{1,1},1),dimension);
for i=1:dimension
    low_dimen(:,i)=1./sqrt(eigval(i,1)).*X*eigvec(:,i);
end

%降至dimension维的database
eigdatabase=cell(1,1);

for i=1:category_num
%本类别的样本数量
sample_num=double(size(database{1,i},2));
    for j=1:sample_num
        for k=1:dimension
            low_dimen_val=low_dimen(:,k)'*(double(database{1,i}{1,j})-u);
            eigdatabase{1,i}{1,j}(k,1)=low_dimen_val;
        end
    end
end
end




