%findFace.m
function faceRect=findFace(I,I_orig)
%תΪ�Ҷ�ͼ��
I2 = rgb2gray(I);

%����4��4ģ�����ֵ�˲�
I2 = medfilt2(I2,[4 4]); 

%������ֵ�˲�
I2 = medfilt2(I2,[18 18]); 

se=strel('arbitrary',50);
I2 = imopen(I2,se);  %��ʴ
se=strel('diamond',50);  %  arbitrary50
I2 = imclose(I2,se);  %����
se=strel('diamond',100);  %  arbitrary50
I2 = imopen(I2,se);  %��ʴ

imLabel = bwlabel(I2);  %���ͼ���е����а���ͨ��
img_reg = regionprops(imLabel, 'area', 'boundingbox', 'perimeter');%���ر�ע����imLabel��һϵ�в���,���������Ҫ������Щ����
rects = cat(1,img_reg.BoundingBox);%����ƴ������BoundingBox,BoundingBox ��ʽΪ [ul_corner width]������ ul_corner �� [x y z ...] ��������ʽ�����߽���ӵ����Ͻǡ�boxwidth �� [x_width y_width ...] ��ʽָ���߽��������ÿ��ά������ĳ��ȡ�
area = cat(1,img_reg.Area);

index = area == max(area);    %�����ͨ���ı��
faceRect=rects(index, :);       %���������ͨ�������ϽǺ����½�����


