%newface.m
function new_img = newface(original_img)
    skin_I=skin(original_img);
    faceRect=findFace(skin_I,original_img);
    %从原图像中裁剪图像
    new_img=imcrop(original_img,faceRect);
    new_img=rgb2gray(new_img);
end

