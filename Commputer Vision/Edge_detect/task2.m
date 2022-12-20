close all;
clc;    
img1=imread('9343 AM.bmp');
img2=imread('10905 JL.bmp');
img3=imread('43590 AM.bmp');

img1=im2gray(img1);
img2=im2gray(img2);
img3=im2gray(img3);             %turn RGB image to gray image

%thresh1 = graythresh(img1);     %get threshold for B/W image
%thresh2 = graythresh(img2);
%thresh3 = graythresh(img3);
%img1=im2bw(img1,thresh1);
%img2=im2bw(img2,thresh2);
%img3=im2bw(img3,thresh3);

img1_gt1=imread('9343 AM Edges.bmp');
img2_gt1=imread('10905 JL Edges.bmp');
img3_gt1=imread('43590 AM Edges.bmp');

img1_gt=img1_gt1(256:768,320:960);
img2_gt=img2_gt1(256:768,320:960);
img3_gt=img3_gt1(256:768,320:960);

psf=fspecial('gaussian',[5,5],1);
img1=imfilter(img1,psf);
img2=imfilter(img2,psf);
img3=imfilter(img3,psf);

%--------sobel---------%
%img1_de_sobel=edge(img1,'sobel');
%img2_de_sobel=edge(img2,'sobel');
%img3_de_sobel=edge(img3,'sobel');
img1_sobelX1 = conv2(img1,sobelX);
img1_sobelY1 = conv2(img1,sobelY);

img2_sobelX1 = conv2(img2,sobelX);
img2_sobelY1 = conv2(img2,sobelY);

img3_sobelX1 = conv2(img3,sobelX);
img3_sobelY1 = conv2(img3,sobelY);

%absolute value
m_img1 = mag(img1_sobelX1,img1_sobelY1);
m_img2 = mag(img2_sobelX1,img2_sobelY1);
m_img3 = mag(img3_sobelX1,img3_sobelY1);

%threshold
img1_de_sobel = (m_img1 >50);
img2_de_sobel = (m_img2 >40);
img3_de_sobel = (m_img3 >30);

figure(1)
subplot(131);
imshow(img1_de_sobel(256:768,320:960));
subplot(132);
imshow(img2_de_sobel(256:768,320:960));
title('Edge Detected with Sobel')
subplot(133);
imshow(img3_de_sobel(256:768,320:960));


%--------Roberts------%
%roberts_img1= edge(img1,'roberts');
%roberts_img2 = edge(img2,'roberts');
%roberts_img3 = edge(img3,'roberts');
load filters
load roberts
img1_robertsX1 = conv2(img1,robertsA);
img1_robertsY1 = conv2(img1,robertsB);

img2_robertsX1 = conv2(img2,robertsA);
img2_robertsY1 = conv2(img2,robertsB);

img3_robertsX1 = conv2(img3,robertsA);
img3_robertsY1 = conv2(img3,robertsB);

%absolute value
m_img1_ro = mag(img1_robertsX1,img1_robertsY1);
m_img2_ro = mag(img2_robertsX1,img2_robertsY1);
m_img3_ro = mag(img3_robertsX1,img3_robertsY1);

roberts_img1 = m_img1_ro >10;
roberts_img2 = m_img2_ro >12;
roberts_img3 = m_img3_ro >4;
figure(2)
subplot(131);
imshow(roberts_img1(256:768,320:960));
subplot(132);
imshow(roberts_img2(256:768,320:960));
title('Edge Detected with Roberts')
subplot(133);
imshow(roberts_img3(256:768,320:960));

%----------First Order Gaussian-----------%
x = mask(-2:2,-2:2,1.4);
img1_Gauss1 = conv2(x,first_order_gaussian_filter_1d_length5,'same');
img1_Gauss2 = conv2(x,first_order_gaussian_filter_1d_length5','same');

img1_Gauss11 = conv2(img1,img1_Gauss1,'same');
img1_Gauss22 = conv2(img1,img1_Gauss2,'same');

img2_Gauss4 = conv2(img2,img1_Gauss1,'same');
img2_Gauss44 = conv2(img2,img1_Gauss2,'same');

img3_GaussJ1 = conv2(img3,img1_Gauss1,'same');
img3_GaussJ2 = conv2(img3,img1_Gauss2,'same');
%absolute value
m_img1_fog=mag(img1_Gauss11,img1_Gauss22);
m_img2_fog=mag(img2_Gauss4,img2_Gauss44);
m_img3_fog=mag(img3_GaussJ1,img3_GaussJ2);

img1_FOG = (m_img1_fog>3);
img2_FOG = (m_img2_fog>4);
img3_FOG = (m_img3_fog>2);

figure(3)
subplot(131);
imshow(img1_FOG(256:768,320:960));
subplot(132);
imshow(img2_FOG(256:768,320:960));
title('Edge Detected with First Order Gaussian')
subplot(133);
imshow(img3_FOG(256:768,320:960));

%----------Laplace-----------%
%kernal_laplace=[1 1 1;1 -8 1;1 1 1];
%Laplace_img1=imfilter(img1,kernal_laplace,'conv','replicate');
%Laplace_img2=imfilter(img2,kernal_laplace,'conv','replicate');
%Laplace_img3=imfilter(img3,kernal_laplace,'conv','replicate');
laplacian4 = [0 -1 0; -1 4 -1; 0 -1 0];
img1_lap = conv2(img1,laplacian4);
img2_lap = conv2(img2,laplacian4);
img3_lap = conv2(img3,laplacian4);

Laplace_img1 = zerocrossing(img1_lap,6);
Laplace_img2 = zerocrossing(img2_lap,6);
Laplace_img3 = zerocrossing(img3_lap,6);

figure(4)
subplot(131);
imshow(Laplace_img1(256:768,320:960));
subplot(132);
imshow(Laplace_img2(256:768,320:960));
title('Edge Detected with Laplace')
subplot(133);
imshow(Laplace_img3(256:768,320:960));

%----------Laplace of Gaussian-----------%
%Laplaceog_img1 = task1(img1,gaussian_filter_5x5);
%Laplaceog_img2 = task1(img2,gaussian_filter_5x5);
%Laplaceog_img3 = task1(img3,gaussian_filter_5x5);
a = mask(-4:4,-4:4,1.4);
laplacian8 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
%AMG = conv2(img1, a);
%AMlog = conv2(AMG,laplacian8,'same');

logg = conv2(a, laplacian8);
img1_log = conv2(img1,logg);
img2_log = conv2(img2,logg);
img3_log = conv2(img3,logg);

Laplaceog_img1 = zerocrossing(img1_log,2);
Laplaceog_img2 = zerocrossing(img2_log,3);
Laplaceog_img3 = zerocrossing(img3_log,2);
figure(5)
subplot(131);
imshow(Laplaceog_img1(256:768,320:960));
subplot(132);
imshow(Laplaceog_img2(256:768,320:960));
title('Edge Detected with LOG')
subplot(133);
imshow(Laplaceog_img3(256:768,320:960));

figure(6)
subplot(131)
imshow(img1_gt)
subplot(132)
imshow(img2_gt)
title('Ground Truth')
subplot(133)
imshow(img3_gt)