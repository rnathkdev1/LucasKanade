load('sylvLucasKanade.mat','rects');
rectswrong=rects;

load('sylvseqextrects.mat','rects');

figure(1)
doplotting2(frames,rectswrong,rects,700);

figure(2)
doplotting2(frames,rectswrong,rects,800);

figure(3)
doplotting2(frames,rectswrong,rects,900);

figure(4)
doplotting2(frames,rectswrong,rects,1000);

figure(5)
doplotting2(frames,rectswrong,rects,1100);
