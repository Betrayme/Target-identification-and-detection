%main.m
database_img=Database_img('.\facedata');
testbase_img=Database_img('.\testdata');
%降低后的维数
dimen_num=10;
[low_dimen,database_img,u]=pcadata(database_img,dimen_num);
testbase_img=lowdimension(testbase_img,low_dimen,dimen_num,u);
[w,w0]=Fisher(database_img);
parten=partenjudge(w,w0,testbase_img{1,2}{1,2});
fprintf('输入图片识别结果为标签为%d的人脸\n',parten)


