
% load adjacency matrix
ring = [0,1,0,0,0,1;1,0,1,0,0,0;0,1,0,1,0,0;0,0,1,0,1,0;0,0,0,1,0,1;1,0,0,0,1,0];
ring_odd = [0,1,0,0,1;1,0,1,0,0;0,1,0,1,0;0,0,1,0,1;1,0,0,1,0];
line = [0,1,0,0,0,0;1,0,1,0,0,0;0,1,0,1,0,0;0,0,1,0,1,0;0,0,0,1,0,1;0,0,0,0,1,0];
star = [0,1,1,1,1,1;1,0,0,0,0,0;1,0,0,0,0,0;1,0,0,0,0,0;1,0,0,0,0,0;1,0,0,0,0,0];
fullyConnected = [0,1,1,1,1,1;1,0,1,1,1,1;1,1,0,1,1,1;1,1,1,0,1,1;1,1,1,1,0,1;1,1,1,1,1,0]; 

disp("Ring_even")
PrintMetrics(ring);
disp("Ring_odd")
PrintMetrics(ring_odd);
disp("Line")
PrintMetrics(line);
disp("Star")
PrintMetrics(star);
disp("Fully connected")
PrintMetrics(fullyConnected);


function PrintMetrics(adjacencyMatrix)
    % create graph from adjacency matrix
    G = graph(adjacencyMatrix);
    figure
    plot(G)
    % do calculations using g
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
    
    % total number of links
    numLinks = sum(pathLengthMatrix(:) == 1)/2;
   
    connection = conncomp(G);
    disp("Connection status");
    disp(connection);
    disp("Total number of links");
    disp(numLinks);
    disp("Average length");
    disp(averageLength)
    disp("Diameter");
    disp(diameter)
end
