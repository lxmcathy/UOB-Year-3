%mutation 
function snnew=mutation(snew,pm)  
  
bn=size(snew,2);  
snnew=snew;  
  
pmm=pro(pm);  %Decide whether to perform mutation or not£¬1:true£¬0:false    
if pmm==1  
   c1=mod(randi([65535]),48);  %Generate a random mutation bit in the range [1,bn-1]  
   c2=mod(randi([65535]),48);  
   chb1=min(c1,c2);  
   chb2=max(c1,c2);  
   x=snew(chb1+1:chb2);  
   snnew(chb1+1:chb2)=fliplr(x);  
end  
end  