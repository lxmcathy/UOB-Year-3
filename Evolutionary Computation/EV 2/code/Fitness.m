function f=Fitness(adjacencyMatrix)
%f =  zeros(popSize,popSize);
    G = graph(adjacencyMatrix);
    dims = size(adjacencyMatrix);
    N = dims(1);
    
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

    
    dis= diameter - averageLength;
    
    f = dis;

end