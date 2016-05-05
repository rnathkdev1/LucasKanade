function mask = SubtractDominantMotion(image1, image2)
mask=0;
M = LucasKanadeAffine(image1, image2);

% I am warping image 1. That is how the LucasKanadeAffine is
% written.

 I = warpH(image2, M, size(image1));
 diffI=image1-I;

 %Normalizing it so that 

%  figure(1)
%  imshow(diffI);

% Determining a threshold for conversion to a binary image

level=graythresh(diffI)+0.015;
% level=0.04;
bw=im2bw(diffI,level);
 
% diffI(diffI>0.1)=logical(1);
% diffI(diffI<=0.1)=logical(0);

% Removing unwanted points from it
se=strel('disk',2);
bw=bwareaopen(bw,5);


bw2=bwareafilt(bw,[0 80]);
% bw3=imdilate(bw2,se);
% 

mask=bw2;



end