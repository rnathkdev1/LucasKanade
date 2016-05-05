function doplotting(frames,rects,i)


imshow(frames(:,:,i));
hold on
rect=rects(i,:);

h=rect(4)-rect(2);
w=rect(3)-rect(1);

rectangle('Position',[rect(1) rect(2) w h],'EdgeColor','g');
end
