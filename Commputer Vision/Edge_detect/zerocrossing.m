function [zc] = zerocrossing(img, t)
zc = zeros(1024,1280);
for i= 2:1:1024
    for j = 2:1:1280
        if ((abs ((img(i-1,j) - img(i,j)))) > t)
            zc(i,j) = 1;
           %zc(i-1,j) = 1;
            %zc(i+1,j) = 1;
        elseif((abs ((img(i,j-1) - img(i,j)))) > t)
            zc(i,j) = 1;
           % zc(i,j-1) = 1;
            %zc(i,j+1) = 1;
        elseif((abs ((img(i-1,j-1) - img(i,j)))) > t)
            zc(i,j) = 1;
          %  zc(i-1,j-1) = 1;
           % zc(i+1,j+1) = 1;
        elseif((abs ((img(i,j-1) - img(i-1, j)))) > t)
            zc(i,j) = 1;
          %  zc(i+1,j-1) = 1;
           % zc(i-1, j+1) = 1;
        end
    end
end


