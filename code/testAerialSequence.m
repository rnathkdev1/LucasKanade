clc
clear
load('../data/aerialseq.mat');
numframes=size(frames,3);
masks=[];
for i=1:numframes-1
    i
    It=im2double(frames(:,:,i));
    It1=im2double(frames(:,:,i+1));

    mask = SubtractDominantMotion(It, It1);
    figure(2)
    imshow(imfuse(mask,It1));
    masks=cat(3,masks,mask);
end

save('masks.mat','masks');

figure(1)
imshow(imfuse(masks(:,:,1),frames(:,:,2)));

figure(2)
imshow(imfuse(masks(:,:,30),frames(:,:,31)));

figure(3)
imshow(imfuse(masks(:,:,60),frames(:,:,61)));

figure(4)
imshow(imfuse(masks(:,:,90),frames(:,:,91)));

figure(5)
imshow(imfuse(masks(:,:,120),frames(:,:,121)));