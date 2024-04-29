%创建样本
u1 = [2,3];
sigma1 = [1 0; 0 2];
num1=100;
r1 = mvnrnd(u1,sigma1,num1);
u2 = [7,8];
sigma2=[3 0; 0 2];
num2=120;
r2 = mvnrnd(u2,sigma2,num2);
u3=[10,3];
sigma3=[1 0; 0 1];
num3=95;
r3 = mvnrnd(u3,sigma3,num3);
X=zeros(num1+num2+num3,3);
X(1:num1,1:2)=r1;
X(num1+1:num1+num2,1:2)=r2;
X(num1+num2+1:num1+num2+num3,1:2)=r3;
num_all=num1+num2+num3;

%分类类别数
categories=3;

%分配类别初始值
step=10;
for i=1:num_all
    cat=mod(i,categories);
    if(cat==0)
        cat=3;
    end
    X(i,3)=cat;
end
%计算样本均值
m=zeros(categories,2);
num=zeros(categories,1);
for i=1:num_all
   num(X(i,3),:)=num(X(i,3),:)+1;
   m(X(i,3),:)=m(X(i,3),:)+X(i,1:2);
end
for i=1:categories
    m(i,:)=m(i,:)/num(i,:);
end

Je_recent=0;
global_cnt=0;
while(1)
    for i=1:num_all
        cnt=0;
        pj=zeros(categories-1,2);   %最后一列存目的类别标签
        for j=1:categories
            if(X(i,3)==j)
                %do nothing
            else
                cnt=cnt+1;
                pj(cnt,1)=num(j)/(num(j)+1)*(X(i,1:2)-m(j,:))*(X(i,1:2)-m(j,:))';
                pj(cnt,2)=j;
            end
        end
        pk=sortrows(pj,1,'ascend'); %按照第一列列排序
        pi=num(X(i,3),1)/(num(X(i,3),1)+1).*(X(i,1:2)-m(X(i,3),:))*(X(i,1:2)-m(X(i,3),:))';
        if(pk(1,1)<pi)
            num(X(i,3),:)=num(X(i,3),:)-1;
            num(pk(1,2),:)=num(pk(1,2),:)+1;
            m(X(i,3),:)=m(X(i,3),:)+1/num(X(i,3),:).*(m(X(i,3),:)-X(i,1:2));
            m(pk(1,2),:)=m(pk(1,2),:)+1/num(pk(1,2),:).*(X(i,1:2)-m(X(i,3),:));
            X(i,3)=pk(1,2);
        end
    %计算Je
    je=0;
        for k=1:num_all
            je=(X(k,1:2)-m(X(k,3),:))*(X(k,1:2)-m(X(k,3),:))'+je;
        end
        if(je==Je_recent)
            global_cnt=global_cnt+1;
            if(global_cnt>1000)
                r=cell(1,categories);
                for l=1:num_all
                    r{1,X(l,3)}=vertcat(r{1,X(l,3)},X(l,1:2));
                end
                subplot(1,2,1)
                plot(r1(:,1),r1(:,2),'.','Color','r')
                hold on
                plot(r2(:,1),r2(:,2),'.','Color','b')
                hold on
                plot(r3(:,1),r3(:,2),'.','Color','k')
                hold on
                title("原始类别")
                subplot(1,2,2)
                plot(r{1,1}(:,1),r{1,1}(:,2),'.','Color','r')
                hold on
                plot(r{1,2}(:,1),r{1,2}(:,2),'.','Color','b')
                hold on
                plot(r{1,3}(:,1),r{1,3}(:,2),'.','Color','k')
                hold on
                title('K-means分类')
                return;
            end
        else
            Je_recent=je;
        end
    end
end



