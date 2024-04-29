%train.m
function y=train(split_img,hidden_num,eta,error_net,itera_num)
%split_img输入图像列组
%hidden_num隐含层节点数量
%eta学习步长
%error_net网络规定均方误差
%itera_num最多允许迭代次数

split_img_row=size(split_img,1);
split_img_col=size(split_img,2);
size_element=size(split_img{1,1},1);

%初始化权重第j行存储各个节点到第j个节点的权重
w_hidden=zeros(hidden_num,size_element);
w_out=zeros(size_element,hidden_num);

%初始化训练输出
y=cell(split_img_row,split_img_col);
for i=1:split_img_row
    for j=1:split_img_col
        y{i,j}=zeros(size_element,1);
    end
end
%累计均方误差
eror=0;
%累计迭代次数
cnt=0;
while(1)
    cnt=cnt+1;
    if(cnt>itera_num)
        print("迭代次数超出限制")
        return
    end
    %计算本次迭代均方误差
    for i=1:split_img_row
        for j=1:split_img_col
            eror=(y{i,j}-split_img{i,j})'*(y{i,j}-split_img{i,j})+eror;
        end
    end
    eror=eror/(split_img_row*split_img_col*size_element);
    if(eror>error_net)
        for i=1:split_img_row
            for j=1:split_img_col
                [y{i,j},hidden_out]=net(split_img{i,j},hidden_num,w_hidden,w_out);

                %修正隐含层->输出层权重
                delta_out=zeros(size_element,1);
                for k=1:size_element
                    delta_out(k,1)=-y{i,j}(k,1)*(1-y{i,j}(k,1))*(split_img{i,j}(k,1)-y{i,j}(k,1));
                end

                %为计算输入层->隐含层做准备
                delta_input=zeros(hidden_num,1);
                for k=1:hidden_num
                    delta_input(k,1)=hidden_out(k,1)*(1-hidden_out(k,1))*(delta_out'*w_out(:,k));
                end

                delta_w_out=zeros(size_element,hidden_num);
                for l=1:size_element
                    for m=1:hidden_num
                        %隐层输出级的第m个节点到输出级第l个节点的权重
                        delta_w_out(l,m)=-eta*delta_out(l,1)*hidden_out(m,1);
                    end
                end
                w_out=w_out+delta_w_out;

                %修正输入层->隐含层权重
                delta_w_hidden=zeros(hidden_num,size_element);
                for l=1:hidden_num
                    for m=1:size_element
                        delta_w_hidden(l,m)=-eta*delta_input(l,1)*split_img{i,j}(m,1);
                    end
                end
                w_hidden=w_hidden+delta_w_hidden;


            end
        end
    else
        return
    end
end
end


