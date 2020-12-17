 I   = imread('00076@13.tif');
 I=rgb2gray(I);
 
 % 0.99 treshold ile resimdeki ölçek alanının tespiti
 BW = imbinarize(I,0.99);
 imshow(BW);
 
 %ölçek bölgesinin tespiti
 labeledImage = logical(BW);
 props = regionprops(labeledImage, 'BoundingBox');
 boundingBox = props.BoundingBox;
 boundingBox=round(boundingBox);
 imshow(I);
 rectangle('Position', boundingBox, 'EdgeColor','r','LineWidth',5 );

 
 %ocr algoritması ile yazının tespiti
 ocrResults = ocr(I, boundingBox);
 charText= ocrResults.Text; 
 strText = convertCharsToStrings(charText);
 %yazıdaki sayı değerlerini çekme
 num = regexp(strText, '\d+', 'match');
 %yazıyı double formatına alma
 num=str2double(num);


