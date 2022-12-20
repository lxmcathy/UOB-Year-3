function f_w=fitness_q5(adjacencyMatrix)
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
    %dis= diameter - averageLength;
    % total number of links
    numLinks = sum(pathLengthMatrix(:) == 1)/2;

    %a1f1 + a2f2 + a3f3 =: fw
    w1 = [0.6 0.2 0.2];
    w2 = [0.2 0.6 0.2];
    w3 = [0.2 0.2 0.6];

    f_w1= averageLength*w1(1)' + diameter*w1(2)' + numLinks*w1(3)';
    f_w2= averageLength*w2(1)' + diameter*w2(2)' + numLinks*w2(3)';
    f_w3= averageLength*w3(1)' + diameter*w3(2)' + numLinks*w3(3)';

    f_w = f_w1; %change to f_w1, f_w2, f_w3

end