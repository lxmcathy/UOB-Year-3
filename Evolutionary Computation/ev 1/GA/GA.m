clear all;
close all;

CityNum=48; 
inn=40; %initial population size  
gnmax=250;  %maximum
pc=0.8; %Crossover rate  
pm=0.5; %Mutation rate
temp_x = [1 6734 1453
    2 2233 10
    3 5530 1424
    4 401 841
    5 3082 1644
    6 7608 4458
    7 7573 3716
    8 7265 1268
    9 6898 1885
    10 1112 2049
    11 5468 2606
    12 5989 2873
    13 4706 2674
    14 4612 2035
    15 6347 2683
    16 6107 669
    17 7611 5184
    18 7462 3590
    19 7732 4723
    20 5900 3561
    21 4483 3369
    22 6101 1110
    23 5199 2182
    24 1633 2809
    25 4307 2322
    26 675 1006
    27 7555 4819
    28 7541 3981
    29 3177 756
    30 7352 4506
    31 7545 2801
    32 3245 3305
    33 6426 3173
    34 4608 1198
    35 23 2216
    36 7248 3779
    37 7762 4595
    38 7392 2244
    39 3484 2829
    40 6271 2135
    41 4985 140
    42 1916 1569
    43 7280 4899
    44 7509 3239
    45 10 2676
    46 6807 2993
    47 5185 3258
    48 3023 1942];
DisArr=zeros(size(temp_x,1));  
city = [temp_x(:,2)';temp_x(:,3)'];
city = city';
%Coding cities using integer coding
for i=1:48  
    for j=1:48
        DisArr(i,j) = sqrt((city(i,1)-city(j,1))^2+(city(i,2)-city(j,2))^2);
    end  
end 
result = zeros(1,30);
for ite =1:30
%generate initial population 
s=zeros(inn,CityNum);  
for i=1:inn  
    s(i,:)=randperm(CityNum);  
end  
[~,p]=fintness(s,DisArr);  
  
gn=1;  
ymean=zeros(gn,1);  
ymin=zeros(gn,1);  
xmin=zeros(inn,CityNum);  
scnew=zeros(inn,CityNum);  
smnew=zeros(inn,CityNum);
tic
while gn<gnmax+1  
   for j=1:2:inn  
      seln=selection(p);  %selection 
      scro=cross(s,seln,pc);  %crossover 
      scnew(j,:)=scro(1,:);  
      scnew(j+1,:)=scro(2,:);  
      smnew(j,:)=mutation(scnew(j,:),pm);  %mutation  
      smnew(j+1,:)=mutation(scnew(j+1,:),pm);  
   end  
   s=smnew;  %new population 
   [f,p]=fintness(s,DisArr);  %fitness of the new population  
   %Record the best and average fitness of current  
   [fmin,nmax]=min(f);  
%    ymean(gn)=1000/mean(f);  
%    ymin(gn)=1000/fmin;  
   ymean(gn)=mean(f);  
   ymin(gn)=fmin;  
   %record the best one  
   x=s(nmax,:);  
   xmin(gn,:)=x;  
  
   gn=gn+1;  
end
toc
[min_ymax,index]=min(ymin);  
bestIn = xmin(index,:);
figure(3);
plot(ymin);xlabel('number of iterations');
ylabel('cost function value');
title('GA algorithm iteration curve');
figure(4);
x = temp_x(:,2)';
y = temp_x(:,3)';
plot(x,y,'*');hold on;
for index=1:numel(x)
    text(x(index),y(index),num2str(index));
end
hold on
plot(x([bestIn,bestIn(1)]),y([bestIn bestIn(1)]));
title(['The shortest distance is:',num2str(min_ymax)]);
%fprintf('The shortest distance obtained by GA:%.2f\n',min_ymax);  
% fprintf('The shortest route obtained by GA');  
% disp(xmin(index,:));  
result(ite) = min_ymax;
%disp(min_ymax);
end
%fprintf('The shortest distance of 30 averages of GA:%.2f\n',mean(result));  
%fprintf('30 times the shortest distance standard deviation of GA:%.2f\n',std(result));  

