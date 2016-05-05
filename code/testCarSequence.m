clc
clear
load('../data/carseq.mat');
numframes=size(frames,3);
%This is for the car sequence
rect=[60, 117, 146, 152]';
%This is for the toy sequence
% rect=[122, 59, 169, 104]';

u=0;
v=0;
rects=[];

%% Performing Lucas Kanade on consecutive frames

for i=1:numframes-1
    i
    rect=rect+[u, v, u, v]';
    It=im2double(frames(:,:,i));
    It1=im2double(frames(:,:,i+1));
    [u,v] = LucasKanade(It, It1, rect);
    rects=cat(2,rects,rect);
end
rect=rect+[u, v, u, v]';
rects=cat(2,rects,rect);
rects=rects';

%% Saving and Displaying
save('carseqrects.mat','rects');

figure(3)
doplotting(frames,rects,1);
figure(4)
doplotting(frames,rects,100);
figure(5)
doplotting(frames,rects,200);
figure(6)
doplotting(frames,rects,300);
figure(7)
doplotting(frames,rects,400);