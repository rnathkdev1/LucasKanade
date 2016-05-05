function doplotting2(frames,rectswrong,rects,i)


imshow(frames(:,:,i));
hold on
rect=rects(i,:);
rect2=rectswrong(i,:);

h=rect(4)-rect(2);
w=rect(3)-rect(1);

h2=rect2(4)-rect2(2);
w2=rect2(3)-rect2(1);

rectangle('Position',[rect(1) rect(2) w h],'EdgeColor','g');
rectangle('Position',[rect2(1) rect2(2) w2 h2],'EdgeColor','r');

end
