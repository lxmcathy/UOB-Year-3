function f = simulated_annealing(N,seed,Pm1,Pm2,mute, MAX_ITER)
if ~exist('mute', 'var')
    % Whether to display various prompts
    mute = 0; 
end
if ~exist('MAX_ITER', 'var')
    MAX_ITER = 20; % Maximum number of interactions at a temperature
end
if ~exist('Pm1', 'var')
    Pm1 = 0.3;% Mutation probability
end
if ~exist('Pm2', 'var')
    Pm2 = 0.4;% Mutation probability
end
tic
rng(seed);% Change this seed if u want other initialization
T_r = exp(0:-0.01:-5); % temperature range factor

solution =randi([0,1],[N,N]);% initialization
for y = 1: N%Make the diagonal of the adjacency matrix 0
        solution(y,y) = 0;
end
solution(:,:) = tril(solution(:,:),-1)+triu(solution(:,:)',0);
while max(conncomp(graph(solution))) ~= 1
        solution =mutation_add(solution,seed);
end
disp(solution)
count = 0;
fs = -Fitness(solution); % fitness of solution
bestsolution = solution;% best solution
f = -Fitness(bestsolution);% fitness of best solution
P = generate_neighbors(solution,Pm1,Pm2,seed); % Generate the neighborhood P of the initial solution
N = zeros(1,10000);
ll = 0;

G = graph(bestsolution);
    dims = size(bestsolution);
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


if ~mute
disp('The initial is：');   
plot(graph(solution));
disp('The fitness is：');
disp(-f);
disp('f1 is');
disp(averageLength);
disp('f2 is');
disp(diameter);
end


TMAX =500;% maximum temperature
T_range = T_r * TMAX; % temperature range
for t = T_range
    for i = 1:MAX_ITER
        count = count + 1;
        ll = ll + 1;
        % pick neighbor
        f_neighbor = -Fitness(P);
        N(ll) = f_neighbor;
        Pt = exp(-(f_neighbor - fs)/t); % compute Pt
        if Pt > rand || Pt >= 1
            fs = f_neighbor;
            solution = P;
            P = generate_neighbors(solution,Pm1,Pm2,seed+count);
        end
        if f_neighbor < f
            bestsolution = P;
            f = f_neighbor;
        end
    end
end
toc
if ~mute
fprintf('The optimal solution obtained by the final search is：\n');
disp(bestsolution);
plot(graph(bestsolution))
disp('The best fitness is：');
disp(-f);
disp('f1 is');
disp(averageLength);
disp('f2 is');
disp(diameter);
end

function P = generate_neighbors(solution,Pm1, Pm2,seed)
% This function generates the neighborhood of the solution according
% mutation
P = solution;
n = length(P);
rng(seed+1)
        prob = rand;
        if prob >= 1-Pm1 % do addlink
            P = mutation_add(P,seed);
        elseif (prob < 1 - Pm1 && prob >= 1-Pm1-Pm2 && sum(P,'all')/2 >= n) % do rmlink
            P = mutation_remove(P,seed);
        else % do rw
            P = Mutation_re(P,seed);
        end
