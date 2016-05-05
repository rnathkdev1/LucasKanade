function M = LucasKanadeAffine(It, It1)
%% Initializing values
 
epsilon=0.1; %This is the tolerance value
tol=1000;
p=zeros(6,1);

%% Starting least squares method for affine Lucas Kanade
while (tol>epsilon)
  
    T=It;
    M=[p(1)+1 p(3) p(5); p(2) p(4)+1 p(6); 0 0 1];
    I = warpH(It1, M, size(T));
    [xcropright, ycropdown,ycroptop]=plothelp(It1,M);
    
    I=I(1+ycroptop:end-ycropdown,1:end-xcropright);
    T=T(1+ycroptop:end-ycropdown,1:end-xcropright);
    

    delta=I-T;
    [Ix,Iy]=gradient(I);
    [X,Y]=meshgrid(1:size(I,2),1:size(I,1));
   
    Ix2=Ix.*Ix;
    Iy2=Iy.*Iy;
    IxIy=Ix.*Iy;
    
    X2=X.*X;
    Y2=Y.*Y;
    XY=X.*Y;
    
  
    A=[sum(sum(X2.*Ix2)) sum(sum(X2.*IxIy)) sum(sum(XY.*Ix2));
       sum(sum(X2.*IxIy)) sum(sum(X2.*Iy2)) sum(sum(XY.*IxIy));
       sum(sum(XY.*Ix2)) sum(sum(XY.*IxIy)) sum(sum(Y2.*Ix2))];
    
    B=[sum(sum(XY.*IxIy)) sum(sum(X.*Ix2)) sum(sum(X.*IxIy));
       sum(sum(XY.*Iy2)) sum(sum(X.*IxIy)) sum(sum(X.*Iy2));
       sum(sum(Y2.*IxIy)) sum(sum(Y.*Ix2)) sum(sum(Y.*IxIy))];
   
    D=[sum(sum(Y2.*Iy2)) sum(sum(Y.*IxIy)) sum(sum(Y.*Iy2));
       sum(sum(Y.*IxIy)) sum(sum(Ix2)) sum(sum(IxIy));
       sum(sum(Y.*Iy2)) sum(sum(Ix.*Iy)) sum(sum(Iy2))];
    
   H=-[A B; B' D];

   b=[sum(sum(X.*Ix.*delta));sum(sum(X.*Iy.*delta));sum(sum(Y.*Ix.*delta));sum(sum(Y.*Iy.*delta));sum(sum(Ix.*delta));sum(sum(Iy.*delta))];
   delP=H\b;
   
   p=p+0.1*delP;

   thistol=sqrt(delP'*delP);
 
   if thistol>tol
       break;
   end
   
   tol=thistol;

end
