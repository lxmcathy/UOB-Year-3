function seln=selection(p)  %Roulette selection
seln=zeros(2,1);  
%Choose two individuals from the population(preferably not the same one) 
for i=1:2  
   r=mod(randi([1,65535]),1000)/1000.0;  %generate a random number  
   prand=p-r;  
   j=1;  
   while prand(j)<0  %Select when the random probability< the individual cumulative probability
       j=j+1;  
   end  
   seln(i)=j; %The serial number of the selected individual 
   if i==2&&j==seln(i-1)    %%If the same, choose again 
       r=rand;  %generate a random number  
       prand=p-r;
       j=1;
       while prand(j)<0  
           j=j+1;  
       end  
   end  
end  
end  