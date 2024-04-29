database_img=Database_img('.\facedata');
[low_dimen,database_img]=pcadata(database_img,10);
category_num=size(database_img,2);
%测试图片 挑取数据库中第7个人的第九张图片
testimg=database_img{1,7}{1,9};
[w,w0]=Fisher(database_img);
parten=partenjudge(w,w0,testimg);
fprintf('输入图片识别结果为标签为%d的人脸\n',parten)


