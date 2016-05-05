function [u,v] = LucasKanade(It, It1, rect)
%% Initializing values

u=0;
v=0;
epsilon=1e-3; %This is the tolerance value
tol=100;

h=rect(4)-rect(2);
w=rect(3)-rect(1);

[X0,Y0]=meshgrid(1:size(It,2),1:size(It,1));

[X,Y]=meshgrid(1:size(It1,2),1:size(It1,1));
[Xq,Yq]=meshgrid(rect(1)+u:rect(3)+u,rect(2)+v:rect(4)+v);
% Rt is of the form [x1 y1 x2 y2]
% Accessing the rectangular Template It(row,col) ie It(y,x)

thisT=interp2(X0,Y0,It,Xq,Yq);
% T=It(rect(2):rect(4),rect(1):rect(3));

figure(1)
subplot(1,2,1)
imshow(It);
hold on
rectangle('Position',[rect(1)+u rect(2)+v w h],'EdgeColor','g');
subplot(1,2,2)
imshow(It1);
hold on

while (tol>epsilon)
    T=thisT;
    % Accessing the rectangle of image2
    [Xq,Yq]=meshgrid(rect(1)+u:rect(3)+u,rect(2)+v:rect(4)+v);
    I=interp2(X,Y,It1,Xq,Yq);
    
    
    
    figure(2)
    imshow(I)
    
%     if size(I,2)~=size(T,2) || size(I,1)~=size(T,1)
%         break;
%     end


    if size(I,2)==size(T,2)-1
        T(:,1)=[];
    end
    
    if size(I,1)==size(T,1)-1
        T(1,:)=[];
    end
    
    if size(I,2)==size(T,2)+1
        I(:,1)=[];
    end
    
    if size(I,1)==size(T,1)+1
        I(1,:)=[];
    end
    
    
    delta=I-T;
    [Ix,Iy]=gradient(I);
    
    figure(1)
    rectangle('Position',[rect(1)+u rect(2)+v w h],'EdgeColor','g');

    sumIxdelta=-1*sum(sum(Ix.*delta));
    sumIydelta=-1*sum(sum(Iy.*delta));
    sumIx2=sum(sum(Ix.^2));
    sumIy2=sum(sum(Iy.^2));
    sumIxIy=sum(sum(Ix.*Iy));
    
    A=[sumIx2 sumIxIy; sumIxIy sumIy2];
    b=[sumIxdelta;sumIydelta];
    
    delP=A\b;
    thistol=delP'*delP;
    
    if abs(thistol-tol)<1e-6
        break
    end
    
    tol=thistol;
    
    u=u+delP(1);
    v=v+delP(2);
    

end



 end