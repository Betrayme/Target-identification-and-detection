%imgsplit
function split_img= imgsplit(I,split_step)
row=size(I,1);
col=size(I,2);
%图片分割
split_block_rowsize=floor(row./split_step);
split_block_colsize=floor(col./split_step);
%存放分割图片的cell
split_cell=cell(split_block_rowsize,split_block_colsize);
for i=1:split_step:split_block_rowsize*split_step-split_step+1
    for j=1:split_step:split_block_colsize*split_step-split_step+1
        split_cell{floor(i/split_step)+1,floor(j/split_step)+1}=I(i:i+split_step-1,j:j+split_step-1);
    end
end

%把split_cell的二维图像重整为列向量
split_img=cell(split_block_rowsize,split_block_colsize);
for i=1:split_block_rowsize
    for j=1:split_block_colsize
        split_img{i,j}=double(reshape(split_cell{i,j},split_step^2,1))/255;
    end
end
end

