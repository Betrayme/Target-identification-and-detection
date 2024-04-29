function database_img=Database_img(TrainDatabasePath)
TrainFiles = dir(TrainDatabasePath);%dir()函数用于获得指定文件夹下的所有子文件夹和文件，并存放在一种文件结构体数组中
database_img=cell(1,1);        %T的每一列对应一个人的所有图像的集合
%根据计算facedata下文件夹个数计算总训练图片数目
for i=3:size(TrainFiles,1) %参数1返回Train_Files的行数
    if not(strcmp(TrainFiles(i).name,'.')|strcmp(TrainFiles(i).name,'..'))
        str=int2str(i-2);%减去.和..项
        TrainFiles_s=dir(strcat(TrainDatabasePath,'\s',str));
        s=cell(1,1);
        for j=3:size(TrainFiles_s,1)
            if not(strcmp(TrainFiles_s(j).name,'.')|strcmp(TrainFiles_s(j).name,'..'))
                str2=int2str(j-2);
                str2=strcat('\',str2,'.pgm'); 
                str2=strcat(strcat(TrainDatabasePath,'\s',str,str2));
                img=imread(str2);
                %img=rgb2gray(img); %pgm是灰度图
                [irow,icol]=size(img);
                temp=reshape(img,irow*icol,1);%把原图展开为(irow*icol)*1矩阵
                s{1,j-2}=temp;  %文件读取前两位不是内容
            end
        end
        database_img{1,i-2}=s;%文件读取前两位不是内容
    end
end
end
