function parten = partenjudge(sorter_w,sorter_w0,X)
%根据Fisher函数给出的m(m-1)/2个分类器判断数据X为哪一类
%sorter_w,sorter_w0分别为Fisher输出的分类器法向量cell和对应的超平面平移量w0
%parten为最终对X分类的结果
%X应为列向量样本
categories=size(sorter_w,2);
for i=1:categories-1
    for j=i+1:categories
        if(g(X,sorter_w{i,j},sorter_w0{i,j})>0)
            if(j==categories)
                parten=i;
                return;
            else
                continue;
            end
        else
            parten=j;
            i=j;
            break;
        end
    end
end
end

function val=g(X,w,w0)
val=w'*X+w0;
end
