function M = LucasKanadeAffine2(It, It1)
%% Initializing values
 
epsilon=1e-5; %This is the tolerance value
tol=1000;
% T=It;
p=zeros(6,1);

% figure(2)
% imshow(It1);

while (tol>epsilon)
  
    T=It1;
    M=[p(1)+1 p(2) p(3); p(4) p(5)+1 p(6); 0 0 1];
        
    I = warpH(It, M, size(T));
    [xcropright, ycropdown,ycroptop]=plothelp(It1,M);
    
    I=I(1+ycroptop:end-ycropdown,1:end-xcropright);
    T=T(1+ycroptop:end-ycropdown,1:end-xcropright);
    
    figure(3)
    imshow(imfuse(I,T,'falsecolor','scaling', 'joint', 'ColorChannels', [1 2 0]))
    %imshow(I)
    
    [X,Y]=meshgrid(1:size(I,2),1:size(I,1));
    [Ix,Iy]=gradient(I);
    Ix2=Ix.*Ix;
    Iy2=Iy.*Iy;
    IxIy=Ix.*Iy;
    
    X2=X.*X;
    Y2=Y.*Y;
    XY=X.*Y;
    
    A=[sum(sum(X2.*Ix2)) sum(sum(XY.*Ix2)) sum(sum(X.*Ix2));
       sum(sum(XY.*Ix2)) sum(sum(Ix2.*Y2)) sum(sum(Y2.*Ix2));
       sum(sum(X.*Ix2)) sum(sum(Y.*Ix2)) sum(sum(Ix2))];
    
    B=[sum(sum(X2.*IxIy)) sum(sum(XY.*IxIy)) sum(sum(X.*IxIy));
       sum(sum(XY.*IxIy)) sum(sum(IxIy.*Y2)) sum(sum(Y2.*IxIy));
       sum(sum(X.*IxIy)) sum(sum(Y.*IxIy)) sum(sum(IxIy))];
   
    D=[sum(sum(X2.*Iy2)) sum(sum(XY.*Iy2)) sum(sum(X.*Iy2));
       sum(sum(XY.*Iy2)) sum(sum(Iy2.*Y2)) sum(sum(Y2.*Iy2));
       sum(sum(X.*Iy2)) sum(sum(Y.*Iy2)) sum(sum(Iy2))];
    
   L=-[A B; B' D];

   spaceTime=cat(3,I,T);
   [~,~,I_t]=gradient(spaceTime);
   I_t(:,:,2)=[];
   
   
   b=[sum(sum(X.*Ix.*I_t));sum(sum(Y.*Ix.*I_t));sum(sum(Ix.*I_t));sum(sum(X.*Iy.*I_t));sum(sum(Y.*Iy.*I_t));sum(sum(Iy.*I_t))];
   delP=L\b;
   p=p+delP;

   thistol=sqrt(delP'*delP);
   
   if thistol>tol
       break;
   end
   
   tol=thistol

end
