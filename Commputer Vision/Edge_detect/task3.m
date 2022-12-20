clear all;
clc;
close all;
img1=imread('9343 AM.bmp');
img2=imread('10905 JL.bmp');
img3=imread('43590 AM.bmp');
img1=im2gray(img1);
img2=im2gray(img2);
img3=im2gray(img3);             %turn RGB image to gray image
thresh1 = graythresh(img1);     %get threshold for B/W image
thresh2 = graythresh(img2);
thresh3 = graythresh(img3);

img1=im2bw(img1,thresh1);
img2=im2bw(img2,thresh2);
img3=im2bw(img3,thresh3);
img1_canny=edge(img1,'canny');
img2_canny=edge(img2,'canny');
img3_canny=edge(img3,'canny');

img1_gt1=imread('9343 AM Edges.bmp');
img2_gt1=imread('10905 JL Edges.bmp');
img3_gt1=imread('43590 AM Edges.bmp');

img1_gt=img1_gt1(256:768,320:960);
img2_gt=img2_gt1(256:768,320:960);
img3_gt=img3_gt1(256:768,320:960);

thresh1 = graythresh(img1_gt);     %get threshold for B/W image
thresh2 = graythresh(img2_gt);
thresh3 = graythresh(img3_gt);

img1_gt=im2bw(img1_gt,thresh1);
img2_gt=im2bw(img2_gt,thresh2);
img3_gt=im2bw(img3_gt,thresh3);

figure(1)
subplot(131);
imshow(img1_canny(256:768,320:960));
subplot(132);
imshow(img2_canny(256:768,320:960));
title('Edge Detected with Canny')
subplot(133);
imshow(img3_canny(256:768,320:960));

