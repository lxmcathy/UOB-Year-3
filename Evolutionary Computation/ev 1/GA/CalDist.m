%fitness function
function F=CalDist(G,diameter,averageLength)  
  
difference=0;  
pathLengthMatrix= zeros(N,N); 
for i=1:N
    for j=1:N
        pathLengthMatrix(i,j) = length(shortestpath(G, i, j))-1;
     end
end 
% average path length
lengthSum = sum(pathLengthMatrix, 'all');
averageLength = lengthSum/(N*(N-1));
% diameter
diameter = max(pathLengthMatrix, [], "all");
difference=difference+(diameter - averageLength);  
F=difference;  
end

