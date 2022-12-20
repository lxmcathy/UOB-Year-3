function f = task1(img,Gaus)
%Input and Denoised with Gauss filter
%I=imread('shakey.150.gif');%load shakey.gif
%figure(1);imshow(img);
title('Original Image');

K=filter2(Gaus,img)/255; %Gauss filter
%figure(2);imshow(K);
title('Gaus Filter Denoised Image');

%--------Laplacian-Gaussian Filter--------%
w = [0 0 1 0 0;0 1 2 1 0;1 2 -16 2 1;0 1 2 1 0;0 0 1 0 0]; %define the kernel to approximate laplacian 
f = imfilter(K,w); %filter with latlacian of gaussian
%figure,imshow(f,[ ]);
title('Edge detection');
%figure,imshow((im2double(img)-K));
end
