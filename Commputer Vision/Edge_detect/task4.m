img1 = imread('9343 AM.bmp');
img1_gt = imread('9343 AM Edges.bmp');
img2 = imread('43590 AM.bmp');
img2_gt = imread('43590 AM Edges.bmp');
img3 = imread('10905 JL.bmp');
img3_gt = imread('10905 JL Edges.bmp');
load filters
%extract green colour from the image, no need to make it grey
img1 = im2gray(img1);
img2 = im2gray(img2);
img3 = im2gray(img3);
%3x3
y = [-3:1:3,-3:1:3,0.8]
AM_sobelX = conv2(y,sobelX,'same');
AM_sobelY = conv2(y,sobelY,'same');

AM_sobelX1 = conv2(img1,sobelX,'same');
AM_sobelY1 = conv2(img1,sobelY,'same');

AM4_sobelX1 = conv2(img2,sobelX,'same');
AM4_sobelY1 = conv2(img2,sobelY,'same');

JL_sobelX1 = conv2(img3,sobelX,'same');
JL_sobelY1 = conv2(img3,sobelY,'same');

%absolute value
m = mag(AM_sobelX1,AM_sobelY1);
m4 = mag(AM4_sobelX1,AM4_sobelY1);
mJL = mag(JL_sobelX1,JL_sobelY1);

%divide it by 255 so it can have values of 0 and 1 - binary image
img1_gt=img1_gt/255;
img2_gt=img2_gt/255;
img3=img3_gt/255;
%figure, show_image(AME)

%if I would change the array, there will be less matches between the images
thresholds = [0:150];
for i = 1:numel(thresholds)
    t = thresholds(i);
    mtmp=m>t;
    mtmp4=m4>t;
    mtmpJ=mJL>t;
    
    tp(i) = nnz(mtmp&img1_gt);
    fp(i) = nnz(mtmp&~img1_gt);
    fn(i) = nnz(~mtmp&img1_gt);
    tn(i) = nnz(~mtmp&~img1_gt);
    
    tp4(i) = nnz(mtmp4&img2_gt);
    fp4(i) = nnz(mtmp4&~img2_gt);
    fn4(i) = nnz(~mtmp4&img2_gt);
    tn4(i) = nnz(~mtmp4&~img2_gt);
    
    tpJ(i) = nnz(mtmpJ&img3);
    fpJ(i) = nnz(mtmpJ&~img3);
    fnJ(i) = nnz(~mtmpJ&img3);
    tnJ(i) = nnz(~mtmpJ&~img3);
end

%sensitivity and specificity
sen=tp./(tp+fn);
spec=1-tn./(tn+fp);
dist=sqrt(spec.^2+(sen-1).^2);

sen4=tp4./(tp4+fn4);
spec4=1-tn4./(tn4+fp4);
%dist=sqrt(spec.^2+(sen-1).^2);

senJ=tpJ./(tpJ+fnJ);
specJ=1-tnJ./(tnJ+fpJ);
dist=sqrt(spec.^2+(sen-1).^2);
%ROC space
figure, plot(spec,sen);
title('Sobel');
xlabel('1 - Specificity');
ylabel('Sensitivity');

hold on
plot(spec4, sen4);

plot(specJ, senJ);
legend('9343 AM','43590 AM', '10905 JL','southeast');
grid on
hold off
xlim([0 1])
ylim([0 1])


%num=num0inAMEclear
AM = read_image('','9343 AM.bmp');
AME = read_image('','9343 AM Edges.bmp');
AM4 = read_image('','43590 AM.bmp');
AME4 = read_image('','43590 AM Edges.bmp');
JL = read_image('','10905 JL.bmp');
JLE = read_image('','10905 JL Edges.bmp');

load filters
load roberts

AMgrey = AM(:, :, 2);
AM4grey = AM4(:, :, 2);
JLgrey = JL(:, :, 2);

%9x9
a = mask(-4:4,-4:4,0.7);
AM_robertsB = conv2(a,robertsB,'same');
AM_robertsA = conv2(a,robertsA,'same');
AM4_robertsA1 = conv2(AM4grey,robertsA,'same');
AM4_robertsB1 = conv2(AM4grey,robertsB,'same');
m4 = mag(AM4_robertsA1,AM4_robertsB1);


AM_robertsA1 = conv2(AMgrey,robertsA,'same');
AM_robertsB1 = conv2(AMgrey,robertsB,'same');
m = mag(AM_robertsA1,AM_robertsB1);

AMj_robertsA1 = conv2(JLgrey,robertsA,'same');
AMj_robertsB1 = conv2(JLgrey,robertsB,'same');
mJL = mag(AMj_robertsA1,AMj_robertsB1);

AME=AME/255;
AME4=AME4/255;
JL=JLE/255;


thresholds = [0:0.5:50];
for i = 1:numel(thresholds)
    t = thresholds(i);
   
    
    mtmp=m>t;
    mtmp4=m4>t;
    mtmpJ=mJL>t;
    
    tp(i) = nnz(mtmp&AME);
    fp(i) = nnz(mtmp&~AME);
    fn(i) = nnz(~mtmp&AME);
    tn(i) = nnz(~mtmp&~AME);
    
    tp4(i) = nnz(mtmp4&AME4);
    fp4(i) = nnz(mtmp4&~AME4);
    fn4(i) = nnz(~mtmp4&AME4);
    tn4(i) = nnz(~mtmp4&~AME4);
    
    tpJ(i) = nnz(mtmpJ&JL);
    fpJ(i) = nnz(mtmpJ&~JL);
    fnJ(i) = nnz(~mtmpJ&JL);
    tnJ(i) = nnz(~mtmpJ&~JL);
end
%sensitivity and specificity
sen=tp./(tp+fn);
spec=1-tn./(tn+fp);
dist=sqrt(spec.^2+(sen-1).^2);

sen4=tp4./(tp4+fn4);
spec4=1-tn4./(tn4+fp4);
%dist=sqrt(spec.^2+(sen-1).^2);

senJ=tpJ./(tpJ+fnJ);
specJ=1-tnJ./(tnJ+fpJ);
dist=sqrt(spec.^2+(sen-1).^2);
%ROC space
figure, plot(spec,sen);
title('Roberts');
xlabel('1 - Specificity');
ylabel('Sensitivity');

hold on
plot(spec4, sen4);

plot(specJ, senJ);
legend('9343 AM','43590 AM', '10905 JL','southeast');
grid on
hold off
xlim([0 1])
ylim([0 1])


% num=nnz(AME);
% num0inAME = TP1+FN1;

AM = read_image('','9343 AM.bmp');
AME = read_image('','9343 AM Edges.bmp');
AM4 = read_image('','43590 AM.bmp');
AME4 = read_image('','43590 AM Edges.bmp');
JL = read_image('','10905 JL.bmp');
JLE = read_image('','10905 JL Edges.bmp');
load filters


laplacian4 = [0 -1 0; -1 4 -1; 0 -1 0];
laplacian8 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
AMgrey = AM(:, :, 2);
AM4grey = AM4(:, :, 2);
JLgrey = JL(:, :, 2);



AMgrey = conv2(AMgrey,laplacian4,'same');
AM4grey = conv2(AM4grey,laplacian4,'same');
JLgrey = conv2(JLgrey,laplacian4,'same');

AME=AME/255;
AME4=AME4/255;
JL=JLE/255;

thresholds = [0:0.5:230];
for i = 1:length(thresholds)
    t = thresholds(i);
    mtmp = zerocrossing(AMgrey,t);
    mtmp4 = zerocrossing(AM4grey,t);
    mtmpJ = zerocrossing(JLgrey,t);
    
    tp(i) = nnz(mtmp&AME);
    fp(i) = nnz(mtmp&~AME);
    fn(i) = nnz(~mtmp&AME);
    tn(i) = nnz(~mtmp&~AME);
    
    tp4(i) = nnz(mtmp4&AME4);
    fp4(i) = nnz(mtmp4&~AME4);
    fn4(i) = nnz(~mtmp4&AME4);
    tn4(i) = nnz(~mtmp4&~AME4);
    
    tpJ(i) = nnz(mtmpJ&JL);
    fpJ(i) = nnz(mtmpJ&~JL);
    fnJ(i) = nnz(~mtmpJ&JL);
    tnJ(i) = nnz(~mtmpJ&~JL);
end

%sensitivity and specificity
sen=tp./(tp+fn);
spec=1-tn./(tn+fp);
dist=sqrt(spec.^2+(sen-1).^2);

sen4=tp4./(tp4+fn4);
spec4=1-tn4./(tn4+fp4);
%dist=sqrt(spec.^2+(sen-1).^2);

senJ=tpJ./(tpJ+fnJ);
specJ=1-tnJ./(tnJ+fpJ);
dist=sqrt(spec.^2+(sen-1).^2);
%ROC space
figure, plot(spec,sen);
title('Laplacian');
xlabel('1 - Specificity');
ylabel('Sensitivity');
grid on
hold on
plot(spec4, sen4);

plot(specJ, senJ);
legend('9343 AM','43590 AM', '10905 JL','southeast');

hold off
xlim([0 1])
ylim([0 1])

AM = read_image('','9343 AM.bmp');
AME = read_image('','9343 AM Edges.bmp');
AM4 = read_image('','43590 AM.bmp');
AME4 = read_image('','43590 AM Edges.bmp');
JL = read_image('','10905 JL.bmp');
JLE = read_image('','10905 JL Edges.bmp');
load filters

AMgrey = AM(:, :, 2);
AM4grey = AM4(:, :, 2);
JLgrey = JL(:, :, 2);

%AM_lap = conv2(AMgrey,conv2(gaussian_filter_3x3,laplacian,'same'),'same');

%AM_laplacian = edge(conv2(AMgrey,laplacian,'same'),'zerocross');

%show_image(AM_lap>0)
%show_image(AM_laplacian>0)

AME=AME/255;
AME4=AME4/255;
JL=JLE/255;

%9x9
a = mask(-4:4,-4:4,1.4);
%7x7
z = mask(-3:3,-3:3,1.1);
%5x5
x = mask(-2:2,-2:2,3);
%3x3
y = mask(-1:1,-1:1,2);
laplacian8 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
AMG = conv2(AMgrey, a,'same');
AMlog = conv2(AMG,laplacian8,'same');

logg = conv2(a, laplacian8,'same');
AMlogg = conv2(AMgrey,logg,'same');

AM4logg = conv2(AM4grey,logg,'same');

AMjlogg = conv2(JLgrey,logg,'same');

thresholds = [0:0.2:50];
for i = 1:length(thresholds)
    t = thresholds(i);
    
    mtmp = zerocrossing(AMlogg,t);
    mtmp4 = zerocrossing(AM4logg,t);
    mtmpJ = zerocrossing(AMjlogg,t);
    
    tp(i) = nnz(mtmp&AME);
    fp(i) = nnz(mtmp&~AME);
    fn(i) = nnz(~mtmp&AME);
    tn(i) = nnz(~mtmp&~AME);
    
    tp4(i) = nnz(mtmp4&AME4);
    fp4(i) = nnz(mtmp4&~AME4);
    fn4(i) = nnz(~mtmp4&AME4);
    tn4(i) = nnz(~mtmp4&~AME4);
    
    tpJ(i) = nnz(mtmpJ&JL);
    fpJ(i) = nnz(mtmpJ&~JL);
    fnJ(i) = nnz(~mtmpJ&JL);
    tnJ(i) = nnz(~mtmpJ&~JL);
end

%sensitivity and specificity
sen=tp./(tp+fn);
spec=1-tn./(tn+fp);
dist=sqrt(spec.^2+(sen-1).^2);

sen4=tp4./(tp4+fn4);
spec4=1-tn4./(tn4+fp4);
%dist=sqrt(spec.^2+(sen-1).^2);

senJ=tpJ./(tpJ+fnJ);
specJ=1-tnJ./(tnJ+fpJ);
dist=sqrt(spec.^2+(sen-1).^2);
%ROC space
figure, plot(spec,sen);
title('Laplacian of Gaussian');
xlabel('1 - Specificity');
ylabel('Sensitivity');

hold on
plot(spec4, sen4);

plot(specJ, senJ);
legend('9343 AM','43590 AM', '10905 JL','southeast');
grid on
hold off
xlim([0 1])
ylim([0 1])

clear
AM = read_image('','9343 AM.bmp');
AME = read_image('','9343 AM Edges.bmp');
AM4 = read_image('','43590 AM.bmp');
AME4 = read_image('','43590 AM Edges.bmp');
JL = read_image('','10905 JL.bmp');
JLE = read_image('','10905 JL Edges.bmp');
load filters

AMgrey = AM(:, :, 2);
AM4grey = AM4(:, :, 2);
JLgrey = JL(:, :, 2);

%5x5
x = mask(-2:2,-2:2,1.4);

AM_Gauss1 = conv2(x,first_order_gaussian_filter_1d_length5,'same');
AM_Gauss2 = conv2(x,first_order_gaussian_filter_1d_length5','same');

AM_Gauss11 = conv2(AMgrey,AM_Gauss1,'same');
AM_Gauss22 = conv2(AMgrey,AM_Gauss2,'same');

AM_Gauss4 = conv2(AM4grey,AM_Gauss1,'same');
AM_Gauss44 = conv2(AM4grey,AM_Gauss2,'same');

AM_GaussJ1 = conv2(JLgrey,AM_Gauss1,'same');
AM_GaussJ2 = conv2(JLgrey,AM_Gauss2,'same');
m=mag(AM_Gauss11,AM_Gauss22);
m4=mag(AM_Gauss4,AM_Gauss44);
mJL=mag(AM_GaussJ1,AM_GaussJ2);

AME=AME/255;
AME4=AME4/255;
JL=JLE/255;

%show_image(n>1)



thresholds = [0:0.2:50];
for i = 1:numel(thresholds)
    t = thresholds(i);
   
    mtmp=m>t;
    mtmp4=m4>t;
    mtmpJ=mJL>t;
    
    tp(i) = nnz(mtmp&AME);
    fp(i) = nnz(mtmp&~AME);
    fn(i) = nnz(~mtmp&AME);
    tn(i) = nnz(~mtmp&~AME);
    
    tp4(i) = nnz(mtmp4&AME4);
    fp4(i) = nnz(mtmp4&~AME4);
    fn4(i) = nnz(~mtmp4&AME4);
    tn4(i) = nnz(~mtmp4&~AME4);
    
    tpJ(i) = nnz(mtmpJ&JL);
    fpJ(i) = nnz(mtmpJ&~JL);
    fnJ(i) = nnz(~mtmpJ&JL);
    tnJ(i) = nnz(~mtmpJ&~JL);
end

%sensitivity and specificity
sen=tp./(tp+fn);
spec=1-tn./(tn+fp);
dist=sqrt(spec.^2+(sen-1).^2);

sen4=tp4./(tp4+fn4);
spec4=1-tn4./(tn4+fp4);
%dist=sqrt(spec.^2+(sen-1).^2);

senJ=tpJ./(tpJ+fnJ);
specJ=1-tnJ./(tnJ+fpJ);
dist=sqrt(spec.^2+(sen-1).^2);
%ROC space
figure, plot(spec,sen);
title('Gaussian');
xlabel('1 - Specificity');
ylabel('Sensitivity');

hold on
plot(spec4, sen4);

plot(specJ, senJ);
legend('9343 AM','43590 AM', '10905 JL','southeast');
grid on
hold off
xlim([0 1])
ylim([0 1])


%hold on
%plot(spec(b),sen(b),'*r')
%[a,b]=min(dist)

img1 = imread('9343 AM.bmp');
img1_gt = imread('9343 AM Edges.bmp');
img2 = imread('43590 AM.bmp');
img2_gt = imread('43590 AM Edges.bmp');
img3 = imread('10905 JL.bmp');
img3_gt = imread('10905 JL Edges.bmp');

img1=im2gray(img1);
img2=im2gray(img2);
img3=im2gray(img3);

img1_canny=edge(img1,'canny');
img2_canny=edge(img2,'canny');
img3_canny=edge(img2,'canny');

thresholds = [0:0.2:50];
for i = 1:numel(thresholds)
    t = thresholds(i);
   
    mtmp=m>t;
    mtmp4=m4>t;
    mtmpJ=mJL>t;
    
    tp(i) = nnz(mtmp&img1_gt);
    fp(i) = nnz(mtmp&~img1_gt);
    fn(i) = nnz(~mtmp&img1_gt);
    tn(i) = nnz(~mtmp&~img1_gt);
    
    tp4(i) = nnz(mtmp4&img2_gt);
    fp4(i) = nnz(mtmp4&~img2_gt);
    fn4(i) = nnz(~mtmp4&img2_gt);
    tn4(i) = nnz(~mtmp4&~img2_gt);
    
    tpJ(i) = nnz(mtmpJ&img3_gt);
    fpJ(i) = nnz(mtmpJ&~img3_gt);
    fnJ(i) = nnz(~mtmpJ&img3_gt);
    tnJ(i) = nnz(~mtmpJ&~img3_gt);
end
sen=tp./(tp+fn);
spec=1-tn./(tn+fp);
dist=sqrt(spec.^2+(sen-1).^2);

sen4=tp4./(tp4+fn4);
spec4=1-tn4./(tn4+fp4);
%dist=sqrt(spec.^2+(sen-1).^2);

senJ=tpJ./(tpJ+fnJ);
specJ=1-tnJ./(tnJ+fpJ);
dist=sqrt(spec.^2+(sen-1).^2);
%ROC space
figure, plot(spec,sen);
title('Canny');
xlabel('1 - Specificity');
ylabel('Sensitivity');

hold on
plot(spec4, sen4);

plot(specJ, senJ);
legend('9343 AM','43590 AM', '10905 JL','southeast');
grid on
hold off
xlim([0 1])
ylim([0 1])

