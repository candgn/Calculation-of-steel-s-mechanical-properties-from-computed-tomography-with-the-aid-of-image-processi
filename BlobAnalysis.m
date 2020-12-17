ocrx;
straight_line;
imgPath="00076@13.tif";
I = imread(imgPath);
figure
%resmi graye çekme
I=rgb2gray(I);
%treshold tespiti
level = graythresh(I);
%resmi binary yapma
BW = imbinarize(I,level);
imshow(I,[]);
%resimdeki bütün siyahları beyaz beyazları siyah yapma
BW = logical(1 - BW);




title('Original Image');



%blob analysis özellikler
Hblob = vision.BlobAnalysis("EccentricityOutputPort",true,"OrientationOutputPort",true,"MajorAxisLengthOutputPort",true...
    ,"MinorAxisLengthOutputPort",true,"MaximumBlobArea",1000000,"MinimumBlobArea",2,...
"Connectivity",4,"MaximumCount",10000000,"ExcludeBorderBlobs",true);

%blob analiz uygulama
[area,centroid,bbox,orientation,majoraxis,minoraxis,eccentricity] = Hblob(BW);


%bboxları çizdirme
for k = 1 : length(bbox)
 
  rectangle('Position', [bbox(k,1),bbox(k,2),bbox(k,3),bbox(k,4)], 'EdgeColor','r','LineWidth',0.5 );
 
end

%renk aralıklarını belirleme(büyük:kırmızı,sarı:orta,yeşil:küçük)

maxAreaofBlobs=max(area);
maxArea1=max(area)/3;
maxArea2=max(area)*2/3;
maxArea3=maxAreaofBlobs;
hold on;
for i=1:length(area)
    if area(i,1)<=maxArea1
        
       
        
        %t=-pi:0.01:pi;
        %x=centroid(i,1)+abs(majoraxis(i))*cos(t);
        %y=centroid(i,2)+abs(minoraxis(i))*sin(t);
        %plot(x,y,'r');
        %area()
        
         t = linspace(0,2*pi);
        %a =  majoraxis(i);
        %b =  minoraxis(i);
        Xc =  centroid(i,1);
        Yc = centroid(i,2);
        phi = deg2rad(orientation(i));
       % x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
       % y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
        
        
        a = (1/2) * sqrt( (majoraxis(i)) ^ 2 + (minoraxis(i)) ^ 2);
        b = a * sqrt(1-eccentricity(i)^2);
        %t = linspace(0, 2 * pi, numPoints); % Absolute angle parameter
        X = a * cos(t);
        Y = b * sin(t);
        % Compute angles relative to (x1, y1).
        %angles = atan2(y2 - y1, x2 - x1);
        x = Xc + X * cos(phi) - Y * sin(phi);
        y = Yc + X * sin(phi) + Y * cos(phi);


        plot(x,y,'r','Linewidth',0.5);
      
        
        
        
        
        
      
        
        
        
    elseif (maxArea1<area(i,1))&&(area(i,1)<=maxArea2)
        t = linspace(0,2*pi);
        %a =  majoraxis(i);
        %b =  minoraxis(i);
        Xc =  centroid(i,1);
        Yc = centroid(i,2);
        phi = deg2rad(orientation(i));
       % x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
       % y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
        
        
        a = (1/2) * sqrt( (majoraxis(i)) ^ 2 + (minoraxis(i)) ^ 2);
        b = a * sqrt(1-eccentricity(i)^2);
        %t = linspace(0, 2 * pi, numPoints); % Absolute angle parameter
        X = a * cos(t);
        Y = b * sin(t);
        % Compute angles relative to (x1, y1).
        %angles = atan2(y2 - y1, x2 - x1);
        x = Xc + X * cos(phi) - Y * sin(phi);
        y = Yc + X * sin(phi) + Y * cos(phi);


        plot(x,y,'g','Linewidth',0.5);
    elseif (maxArea2<area(i,1))&&(area(i,1)<=maxArea3)
        
        t = linspace(0,2*pi,50);
        %a =  majoraxis(i);
        %b =  minoraxis(i);
        Xc =  centroid(i,1);
        Yc = centroid(i,2);
        phi = deg2rad(orientation(i));
       % x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
       % y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
        
        
        a = (1/2) * sqrt( (majoraxis(i)) ^ 2 + (minoraxis(i)) ^ 2);
        b = a * sqrt(1-eccentricity(i)^2);
        %t = linspace(0, 2 * pi, numPoints); % Absolute angle parameter
        X = a * cos(t);
        Y = b * sin(t);
        % Compute angles relative to (x1, y1).
        %angles = atan2(y2 - y1, x2 - x1);
        x = Xc + X * cos(phi) - Y * sin(phi);
        y = Yc + X * sin(phi) + Y * cos(phi);


        plot(x,y,'b','Linewidth',0.5);
        
        %t = linspace(0,2*pi,50);
        %a =  majoraxis(i);
        %b =  minoraxis(i);
        %Xc =  centroid(i,1);
        %Yc = centroid(i,2);
        %phi = deg2rad(orientation(i));
        %x = Xc + a*cos(t)*cos(phi) - b*sin(t)*sin(phi);
        %y = Yc + a*cos(t)*sin(phi) + b*sin(t)*cos(phi);
        %plot(x,y,'b','Linewidth',0.5);%%
        
    end

end
hold off;
figure;

%blobların gerçek alanlarını belirlemek için değşikenleri doğru formata çekme
area=double(area);
uzunluk=double(uzunluk);
num=double(num);

%blobların gerçek alanlarına göre histogram oluşturma
realArea=area*num/uzunluk;

histogram(realArea,'Normalization','probability');
ylabel("Frequency");
hold on
yyaxis right
cdfplot(realArea);
ylabel("Cumulative Frequency");
xlabel("Real Area");
title("Real Area of Blobs");

figure;


%eccentricity histogramı
histogram(eccentricity,'Normalization','probability');
ylabel("Frequency");
hold on
yyaxis right
cdfplot(eccentricity);
ylabel("Cumulative Frequency");
xlabel("Eccentiricity");
title("Eccentiricity");


%blob sayısı
numberOfBlobs=length(area);

%resmin ölçeği
scaleOfImage=num/uzunluk;

%blobun tüm resim alannına yüzdesi.
sumBlobArea=sum(area);
[d1,d2]=size(BW);
imageArea=(d1*d2);
percentAreaofBlobs=sumBlobArea/(imageArea);

%text dosyasına yazdırma
fid = fopen('outputData.txt','wt');
fprintf(fid,'Pic %s\n',imgPath);
fprintf(fid,'Number %i\n',numberOfBlobs);
fprintf(fid,'Scale %7.3f\n',scaleOfImage);
fprintf(fid,'Percent %7.3f\n',percentAreaofBlobs);
fclose(fid);

%csv'ye yazdırma
varNames = {'Centroidx','Centroidy','Area','Eccentricity','Orientation','Major','Minor'};
T = table(centroid(:,1),centroid(:,2),realArea,eccentricity,orientation,majoraxis,minoraxis,'VariableNames',varNames);
writetable(T,'outputData.csv')
type 'outputData.csv';






    









