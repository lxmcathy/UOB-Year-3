function [dis,p]=fintness(s,dislist)%Incoming initial population, distance
  
inn=size(s,1);  %read population size  
dis=zeros(inn,1);  
for i=1:inn  
   dis(i)=CalDist(dislist,s(i,:));  %Calculate the function value(the fitness)  
end  

f=1000./dis'; %Take the reciprocal distance  
  
%Calculate the probability of being selected based on the fitness of the individual 
fsum=0;  
for i=1:inn  
   fsum=fsum+f(i)^15;% Let individuals with better fitness have a higher probability of being selected  
end  
ps=zeros(inn,1);  
for i=1:inn  
   ps(i)=f(i)^15/fsum;  
end  
  
%Calculate cumulative probability  
p=zeros(inn,1);  
p(1)=ps(1);  
for i=2:inn  
   p(i)=p(i-1)+ps(i);  
end  
p=p';  
end  