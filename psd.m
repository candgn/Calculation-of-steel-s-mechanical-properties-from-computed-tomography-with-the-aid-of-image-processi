
clc;clear; close all;
A=imread('00059@09.tif');
Resolution=5;
if ndims(A)==3; A=rgb2gray(A); end
A=imbinarize(A,graythresh(A));
Bins=20;
Conn=8;
[s1,s2]=size(A);
A=bwmorph(A,'majority',10);
Poro=sum(sum(~A))/(s1*s2);
D=-bwdist(A,'cityblock');
B=medfilt2(D,[3 3]);
B=watershed(B,Conn);
Pr=zeros(s1,s2);
for I=1:s1
    for J=1:s2
        if A(I,J)==0 && B(I,J)~=0
            Pr(I,J)=1;
        end
    end
end
Pr=bwareaopen(Pr,9,Conn);
[Pr_L,Pr_n]=bwlabel(Pr,Conn);
V=zeros(Pr_n,1);
for I=1:s1
    for J=1:s2
        if Pr_L(I,J)~=0
            V(Pr_L(I,J))=V(Pr_L(I,J))+1;
        end
    end
end
R=Resolution.*(V./pi).^.5; 
Average_pore_radius_micron=mean(R)
Standard_deviation_of_pore_radius_micron=std(R)
RGB=label2rgb(Pr_L,'jet', 'w', 'shuffle');
imshow(RGB)
