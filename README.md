# 文件结构
## Fisher_identifier 人脸特征提取和使用Fisher分类器人脸识别的程序
Database_img.m--建立图像库,将facedata中的数据一一映射为cell提供索引  
Fisher.m--Fisher多类线性分类器函数  
guassdata_2.m和guasstest.m--可视化分类器的测试函数  
main.m--主函数  
partenjudge.m--根据Fisher.m的分类器输出判断新样本的类别  
pcadata.m--提取图像特征降维  
sorted.m--给特征值排序  
findFace.m--检测人脸返回人脸区域  
lowdimesion.m--将待测样本集按照原样本集的正交基降维  
newface.m--创建新的样本  
skin.m--根据肤色找到可能的人脸区域  
## Neural_networks 建立三层神经网络构建自编码器
Lena.bmp--输入图像  
imgsplit.m--分割图像  
main.m--主程序  
net.m--建立三层神经网络  
train.m--训练net.m建立的神经网络  
## Cluster 多类聚类问题求解
main.m--主函数
