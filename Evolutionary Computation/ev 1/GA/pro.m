%Judging whether to mutate (crossover) according to the probability of mutation (crossover)
%((rand()%100 + 0.0) / 100)
%The random number generated < the probability of mutation (crossover), then mutation (crossover)
function pcc=pro(pc)  
    test(1:100)=0;  
    l=round(100*pc);  
    test(1:l)=1;  
    n=round(rand*99)+1;  
    pcc=test(n);     
end  