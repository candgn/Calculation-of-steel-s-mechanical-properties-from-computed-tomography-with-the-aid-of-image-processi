 I   = imread('00076@13.tif');
I=rgb2gray(I);
BW = imbinarize(I,0.99);
imshow(BW);
labeledImage = logical(BW);
props = regionprops(labeledImage, 'BoundingBox');
boundingBox = props.BoundingBox;
boundingBox=round(boundingBox);
croppedImage = imcrop(I, boundingBox);
imshow(croppedImage);

bw = edge(croppedImage,'sobel',0.03);
%figure;
[H,theta,rho]=hough(bw);% Wir haben ein Matrix aus H, rho und theta Werten gemacht."rcos(theta)+rsin(theta)"->>>(x,y)->(r,theta)%

%imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,...
%            'InitialMagnification','fit');
%        axis on, axis normal,hold on;
%        colormap(hot);
        
kenar = 15;%Wir haben maximale Anzahl der Ecke bestimmen. %
P = houghpeaks(H,kenar ); %Hier haben wir Peak Punkte bestimmen.%
x = theta(P(:,2));%Wir haben hier alle Spalten in zweite Zeile genommen.Theta werden zu x Werten gleich machen.%
y = rho(P(:,1));% Wir haben hier alle Spalten in erste Zeile genommen.Rho Werten werden zu y Werten gleich gemacht.%
%figure;
%plot(x,y,'s','color','black');
dogrular = houghlines(bw, theta , rho, P);%Wir haben Kantenlinien gefunden(in Termen (x,y) und (rho,theta) Werten).point1 und point2 Werten sind Anfangs- und Endpunkten in der Linien%
figure;
imshow(croppedImage); hold on;
 for i = 1: length(dogrular)
    xy = [dogrular(i).point1; dogrular(i).point2;];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'color','green');
    hold on;
    plot(xy(1,1),xy(1,2),'x','color','yellow');
    plot(xy(2,1),xy(2,2),'x','color','red');
 end

%çizginin kaç piksel olduğunu hesaplama
uzunluk=dogrular.point2(1,1)-dogrular.point1(1,1);
