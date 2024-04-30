%lowdemension.m
function eigdatabase=lowdimension(database,low_dimen,dimension,u)
%database输入要降维的列向量数据库
%low_dimen输入规范正交基
%eigdatabase输出输入图像的规范正交基投影数据库
%dimension压缩后的维度
%u样本集均值向量
category_num=size(database,2);
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