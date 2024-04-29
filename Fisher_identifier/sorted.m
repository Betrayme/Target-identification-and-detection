function [sorted_X,sorted_D]=sorted(X,direction)
    [X1,D]=eig(X); %对矩阵求特征值和特征向量
    col_vector=diag(D); %将特征值矩阵转换为只有一列的向量
    X1=[X1',col_vector]; %将特征值整列追加到特征向量(转置)最后
    [row,col]=size(X1); 
    sorted_result=sortrows(X1,col,direction); %按照最后一列排序
    sorted_X=sorted_result(:,1:end-1)'; %返回排序后特征向量每一列为特征向量(注意最后的转置)
    sorted_D=sorted_result(:,end);  %返回排序后的特征值列向量
end
