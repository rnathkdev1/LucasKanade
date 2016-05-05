function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

u=0;%randperm(80,1);
v=0;%randperm(80,1);
prevtol=0;
numwts=size(bases,3);
wts=zeros(numwts,1);

epsilon=1e-3; %This is the tolerance value
tol=100;

h=rect(4)-rect(2);
w=rect(3)-rect(1);

[X0,Y0]=meshgrid(1:size(It,2),1:size(It,1));

[X,Y]=meshgrid(1:size(It1,2),1:size(It1,1));
[Xq,Yq]=meshgrid(rect(1)+u:rect(3)+u,rect(2)+v:rect(4)+v);
% Rt is of the form [x1 y1 x2 y2]
% Accessing the rectangular Template It(row,col) ie It(y,x)

T=interp2(X0,Y0,It,Xq,Yq);
% T=It(rect(2):rect(4),rect(1):rect(3));

figure(1)
subplot(1,2,1)
imshow(It);
hold on
rectangle('Position',[rect(1)+u rect(2)+v w h],'EdgeColor','g');
subplot(1,2,2)
imshow(It1);
hold on

D=zeros(10,10);

for i=1:numwts
    nowbasis=bases(:,:,i);
    nowbasis=repmat(nowbasis,[1 1 numwts]);
    prodBasis=bases.*nowbasis;
    D(i,:)=sum(sum(prodBasis));
end


while (tol>epsilon)
    % Accessing the rectangle of image2
    [Xq,Yq]=meshgrid(rect(1)+u:rect(3)+u,rect(2)+v:rect(4)+v);
    I=interp2(X,Y,It1,Xq,Yq);
    
    figure(2)
    imshow(I)
    
    if size(I,2)~=size(T,2) || size(I,1)~=size(T,1)
        break;
    end
    
    
    delta=I-T;
    [Ix,Iy]=gradient(I);
    
    figure(1)
    rectangle('Position',[rect(1)+u rect(2)+v w h],'EdgeColor','g');
    
%     Ix=sum(sum(Ix));
%     Iy=sum(sum(Iy));
%     A=[Ix^2 Ix*Iy; Ix*Iy Iy^2];
%     b=sum(sum(delta))*[Ix;Iy];
    

    sumIxD=-1*sum(sum(Ix.*delta));
    sumIyD=-1*sum(sum(Iy.*delta));
    sumIx2=sum(sum(Ix.^2));
    sumIy2=sum(sum(Iy.^2));
    sumIxIy=sum(sum(Ix.*Iy));
    
    Ix3D=repmat(Ix,[1 1 numwts]);
    Iy3D=repmat(Iy,[1 1 numwts]);
   
    BIx=bases(1:size(Ix3D,1),1:size(Ix3D,2),:).*Ix3D;
    BIy=bases(1:size(Iy3D,1),1:size(Iy3D,2),:).*Iy3D;
    sumBIx(1,:)=sum(sum(BIx));
    sumBIy(1,:)=sum(sum(BIy));
    
    deltarep=repmat(delta,[1 1 numwts]);
    prodb2=bases(1:size(deltarep,1),1:size(deltarep,2),:).*deltarep;
    
    b2(:,1)=sum(sum(prodb2));
    
    A=[sumIx2 sumIxIy; sumIxIy sumIy2];
    B=[sumBIx;sumBIy];
    
    L=[A B; B' D];
    
    b=[sumIxD;sumIyD;b2];
    
    delP=L\b;
    
    tol=delP(1:2)'*delP(1:2);
    
    if abs(prevtol-tol) < 1e-3
        break;
    end
    prevtol=tol;
    
    u=u+delP(1);
    v=v+delP(2);
    
    wts=wts+delP(3,:);
    

end

end
