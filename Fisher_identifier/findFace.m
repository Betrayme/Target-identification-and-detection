%findFace.m
function faceRect=findFace(I,I_orig)
%转为灰度图像
I2 = rgb2gray(I);

%进行4×4模板的中值滤波
I2 = medfilt2(I2,[4 4]); 

%进行中值滤波
I2 = medfilt2(I2,[18 18]); 

se=strel('arbitrary',50);
I2 = imopen(I2,se);  %腐蚀
se=strel('diamond',50);  %  arbitrary50
I2 = imclose(I2,se);  %膨胀
se=strel('diamond',100);  %  arbitrary50
I2 = imopen(I2,se);  %腐蚀

imLabel = bwlabel(I2);  %标出图像中的所有八连通域
img_reg = regionprops(imLabel, 'area', 'boundingbox', 'perimeter');%返回标注矩阵imLabel的一系列参量,后面参数是要返回那些参量
rects = cat(1,img_reg.BoundingBox);%按列拼接所有BoundingBox,BoundingBox 形式为 [ul_corner width]，这里 ul_corner 以 [x y z ...] 的坐标形式给出边界盒子的左上角、boxwidth 以 [x_width y_width ...] 形式指出边界盒子沿着每个维数方向的长度。
area = cat(1,img_reg.Area);

index = area == max(area);    %最大连通区的标号
faceRect=rects(index, :);       %返回最大连通区域左上角和右下角坐标


