clear all; %清除所有变量
close all; %清图
clc ;      %清屏
C=[
    1 6734 1453
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
    48 3023 1942   
    ];%Coordinates
    
n=size(C,1); %number of cities
%disp(n);
T=1000;     %Initial temperature
T0=0.001;
L=10000;       %Markov length
K=0.98;      %cooling rate

%city coordinates struct
S0 = [randperm(n)];
city=struct([]);

for i=1:n    
    city(S0(i)).x=C(S0(i),2);
    city(S0(i)).y=C(S0(i),3);
    city(S0(i)).index=C(S0(i),1);
end

l=1;        %iteration count
len(l)=func5(city,n); %length after iteration

%result = zeros(1,30);
%for ite = 1:30

%while T>T0
    %Multiple iterative perturbations, multiple trials before temperature reduction
    for i=1:L        
        %Calculate the distance of origin path
        len1=func5(city,n);
        %generate random disturbances
        %Randomly permute the coordinates of two different cities
        p1=floor(1+n*rand);
        p2=floor(1+n*rand);
        while p1==p2
            p1=floor(1+n*rand);
            p2=floor(1+n*rand);
        end
        r = [p1,p2];
        r = sort(r);
        p1 = r(1);
        p2 = r(2);
        tmp_city=city;
        %%swap elements
        tmp_city = [tmp_city(1:p1-1), tmp_city(p2:-1:p1), tmp_city(p2+1:end)];

% 
%         tmp=tmp_city(p1);
%         tmp_city(p1)=tmp_city(p2);
%         tmp_city(p2)=tmp;

        %Calculate the total distance of the new route
        len2=func5(tmp_city,n);
        %Diiferent distance/Energy
        delta_e=len2-len1;
        %new route is better, then replace
        if delta_e<0
            city=tmp_city;
        else
            %Choose whether to accept or not with a certain probability
            if exp(-delta_e/T)>rand()
                city=tmp_city;
            end
        end
    %end
    l=l+1;          %iteration number +1    
    %Calculate the total distance of the new route
    len(l)=func5(city,n);
    %温度不断下降
    T=T*K;
    end
%end


 x = C(:,2)';
 y = C(:,3)';
% plot(x,y,'*');
for j=1:48
    text(x(j),y(j),num2str(j));
  for i=1:n-1
      plot([city(i).x,city(i+1).x],[city(i).y,city(i+1).y]);
       hold on;
       plot([city(n).x,city(1).x],[city(n).y,city(1).y]);
       %(x(i),y(i),num2str(i));
       %disp(city(i).index);
  end
  %disp(city(j).index);
end
title(['The shortest distance is:',num2str(len(l))]);

%result(ite) = (len(l));
%disp(result);

%end

%disp('2nd figure start');
figure(2)
plot(len);
xlabel('number of iterations');
ylabel('Objective function value');
title('fitness evolution curve');
%disp('2nd figure finish');
%disp(city);

%Calculation function
function len=func5(city,n)
len=0;
for i=1:n-1
    len=len+sqrt((city(i).x-city(i+1).x)^2+(city(i).y-city(i+1).y)^2);
end
len=len+sqrt((city(n).x-city(1).x)^2+(city(n).y-city(1).y)^2);
end