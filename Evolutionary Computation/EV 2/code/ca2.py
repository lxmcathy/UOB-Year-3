import random
import copy


import matplotlib.pyplot as plt

from numpy import average, ma, matrix



class Graph():
    def __init__(self, N):

        self.N = N
        self.adjacencyMatrix = []
        self.distanceMatrix = []

        for i in range(N):
            self.adjacencyMatrix.append([0 for j in range(N)])
            self.distanceMatrix.append([float("INF") for j in range(N)])



    def addEdge(self, v1, v2):
        if v1 == v2:
            return
        
        self.adjacencyMatrix[v1][v2] = 1
        self.adjacencyMatrix[v2][v1] = 1

        self.updateDistanceMatrix()

    def deleteEdge(self, v1, v2):
        if self.adjacencyMatrix[v1][v2] == 0:
            return

        self.adjacencyMatrix[v1][v2] = 0
        self.adjacencyMatrix[v2][v1] = 0

        self.updateDistanceMatrix()


    def shortestPath(self, v1, v2):

        if v1 == v2:
            return 0
        visited = []

        dist = -1
        queue = [[v1]]

        while queue:

            path = queue.pop(0)
            node = path[-1]

            if node not in visited:

                visited.append(node)
                
                for i in range(len(self.adjacencyMatrix)):

                    if self.adjacencyMatrix[node][i] == 0:
                        continue

                    newPath = list(path)
                    newPath.append(i)
                    queue.append(newPath)

                    if i == v2:
                        return len(newPath) - 1
                    

        return float('INF')

    def updateDistanceMatrix(self):

        for i in range(self.N):
            for j in range(self.N):

                self.distanceMatrix[i][j] = self.shortestPath(i, j)



    def displayMatrix(self):
        
        for row in self.adjacencyMatrix:
            print(row)



def addEdge(matrix, v1, v2):

    if v1 == v2:
        return matrix

    matrix[v1][v2] = 1
    matrix[v2][v1] = 1

    return matrix

def removeEdge(matrix, v1, v2):

    if v1 == v2:
        return matrix

    matrix[v2][v1] = 0
    matrix[v1][v2] = 0

    return matrix

def shortestPath(v1, v2, adjacencyMatrix):

    if v1 == v2:
        return 0
    visited = []

    dist = -1
    queue = [[v1]]

    while queue:

        path = queue.pop(0)
        node = path[-1]

        if node not in visited:

            visited.append(node)
            
            for i in range(len(adjacencyMatrix)):

                if adjacencyMatrix[node][i] == 0:
                    continue

                newPath = list(path)
                newPath.append(i)
                queue.append(newPath)

                if i == v2:
                    return len(newPath) - 1
                

    return float('INF')


def f1(adjacencyMatrix : list):
    N = len(adjacencyMatrix)
    # use the adjacency Matrix to calculate the distance Matrix
    distanceMatrix = [[float("INF") for _ in range(N)] for _ in range(N)]
    sum_dist = 0

    for i in range(N):

        for j in range(N):

            distanceMatrix[i][j] = shortestPath(i, j, adjacencyMatrix)

            sum_dist += distanceMatrix[i][j]

    average_path_length = sum_dist / (N * (N - 1))
    # print(distanceMatrix)

    return average_path_length

def f2(adjacencyMatrix:list):

    N = len(adjacencyMatrix)

    diameter = 0

    # use the adjacency Matrix to calculate the distance Matrix

    distanceMatrix = [[float("INF") for _ in range(N)] for _ in range(N)]

    for i in range(N):

        for j in range(N):

            distanceMatrix[i][j] = shortestPath(i, j, adjacencyMatrix)

            # find the longest path distance

            diameter = distanceMatrix[i][j] if distanceMatrix[i][j] > diameter else diameter

    return diameter

def f3(adjacencyMatrix:list):

    N = len(adjacencyMatrix)

    num_links = 0

    for i in range(N):

        num_links += sum(adjacencyMatrix[i])

    return num_links / 2

def checkConnected(adjacencyMatrix):

    N = len(adjacencyMatrix)

    distanceMatrix = [[float("INF") for _ in range(N)] for _ in range(N)]

    for i in range(N):

        for j in range(N):

            distanceMatrix[i][j] = shortestPath(i, j, adjacencyMatrix)

            if distanceMatrix[i][j] == float("INF"):
                return False


    return True

    

def plot_graph(adj_matrix, name):

    n = len(adj_matrix)
    plt.figure(figsize = (20, 10))

    x = []
    y = []
    while len(x) != n:

        x_i = random.randint(0, 50)
        y_i = random.randint(0, 50)

        if x_i in x and y_i in y: # if the point is already generated, random agaiin
            continue

        x.append(x_i)
        y.append(y_i)

    # plot the randomly generated graph
    plt.plot(x, y, 'r.')
    plt.title(f"Randomly Generated {n}-Vertices graph with input adjacencyMatrix")

    # connect the vertices using adj matrix

    for i in range(len(x) - 1):

        x_i = x[i]
        y_i = y[i]

        for j in range(i + 1, len(x)):
            if adj_matrix[i][j] == 1:
                x_j = x[j]
                y_j = y[j]
                start = (x_i, x_j)
                end = (y_i, y_j)
                plt.plot(start, end)

    plt.savefig(f"randomGraph_{n}-Nodes_{name}.png")
    plt.show()








        







    
# test Function f1 - Question 2(a)

adjacencyMatrix_line= [
    [0, 1, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0, 1],
    [0, 0, 0, 0, 1, 0]
]


adjacencyMatrix_oddRing =[
    [0, 1, 0, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 1, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0],
    [0, 0, 0, 1, 0, 1, 0],
    [0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 1, 0]
]
adjacencyMatrix_evenRing =[
    [0, 1, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 1, 0]
]
adjacencyMatrix_star =[

    [0, 0, 0, 0, 1], 
    [0, 0, 0, 0, 1],
    [0, 0, 0, 0, 1], 
    [0, 0, 0, 0, 1],
    [1, 1, 1, 1, 0]
]

adjacencyMatrix_fullyConnected =[

    [0, 1, 1, 1, 1], 
    [1, 0, 1, 1, 1],
    [1, 1, 0, 1, 1], 
    [1, 1, 1, 0, 1],
    [1, 1, 1, 1, 0]
]

adjacencyMatrix_case_1 = [
    [0, 1, 0, 0, 1, 0],
    [1, 0, 1, 0, 1, 0],
    [0, 1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1, 1],
    [1, 1, 0, 1, 0, 0],
    [0, 0, 0, 1, 0, 0]
]

adjacencyMatrix_case_2 = [
    [0, 1, 1, 0, 1],
    [1, 0, 0, 1, 1],
    [1, 0, 0, 0, 1],
    [0, 1, 0, 0, 0],
    [1, 1, 1, 0, 0]
]

adjacencyMatrix_unconnected_graph_matrix = [
    [0, 0, 1, 1, 0],
    [0, 0, 0, 1, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [0, 0, 0, 0, 0]
]

# plot_graph(adjacencyMatrix_evenRing)
# plot_graph(adjacencyMatrix_star)
# plot_graph(adjacencyMatrix_fullyConnected)

# plot_graph(adjacencyMatrix_case_1)
# plot_graph(adjacencyMatrix_case_2)
# plot_graph(adjacencyMatrix_unconnected_graph_matrix)


# print(f1(adjacencyMatrix_case_1))
# print(f1(adjacencyMatrix_case_2))
print()
print("--------------------------------Question 2(a) ---------------------------------")
print("The Average path length of Line graph with 6 Node: ", f1(adjacencyMatrix_line))
print("The Average path length of oddRing graph with 7 Node: ",f1(adjacencyMatrix_oddRing))
print("The Average path length of evenRing graph with 6 Node: ",f1(adjacencyMatrix_evenRing))
print("The Average path length of Stargraph with 5 Node: ",f1(adjacencyMatrix_star))
print("The Average path length of fully connected graph with 5 Node: ",f1(adjacencyMatrix_fullyConnected))


print()
print("--------------------------------Question 2(b) ---------------------------------")
print()
print("The diameter of Line graph with 6 Node: ", f2(adjacencyMatrix_line))
print("The diameter of oddRing graph with 7 Node: ",f2(adjacencyMatrix_oddRing))
print("The diameter of evenRing graph with 6 Node: ",f2(adjacencyMatrix_evenRing))
print("The diameter  of Stargraph with 5 Node: ",f2(adjacencyMatrix_star))
print("The Average path length of fully connected graphwith 5 Node: ",f2(adjacencyMatrix_fullyConnected))
print()
print("--------------------------------Question 2(c1) ---------------------------------")
print()
print("The number of linkes of Line graph with 6 Node: ", f3(adjacencyMatrix_line))
print("The number of linkes of oddRing graph with 7 Node: ",f3(adjacencyMatrix_oddRing))
print("The number of linkes of evenRing graph with 6 Node: ",f3(adjacencyMatrix_evenRing))
print("The number of linkes of of Stargraph with 5 Node: ",f3(adjacencyMatrix_star))
print("The Average path length of fully connected graph with 5 Node: ",f3(adjacencyMatrix_fullyConnected))
print()
print("--------------------------------Question 2(c2) ---------------------------------")
print()
print("Check if the Line graph with 6 Node is Connected: ", checkConnected(adjacencyMatrix_line))
print("Check if the oddRing graph with 7 Nodei s Connected: ",checkConnected(adjacencyMatrix_oddRing))
print("Check if the evenRing graph with 6 Node is Connected: ",checkConnected(adjacencyMatrix_evenRing))
print("Check if the Stargraph with 5 Nodes is Connected: ",checkConnected(adjacencyMatrix_star))
print("Check if the fully connected graph with 5 Nodes is Connected: ",checkConnected(adjacencyMatrix_fullyConnected))
print("Check if the Unconnected graph example with 5 Nodes is connected:  ",checkConnected(adjacencyMatrix_unconnected_graph_matrix))
print("------------------------------Graph 1 Results-----------------------------------")
print()
print("The average path length of graph_1 :", f1(adjacencyMatrix_case_1))
print("The diameter of graph_1 : ", f2(adjacencyMatrix_case_1))
print("The number of links of graph 1:", f3(adjacencyMatrix_case_1))
print("Check if graph 1 is connected :", checkConnected(adjacencyMatrix_case_1))
print("------------------------------Graph 2 Results-----------------------------------")
print()
print("The average path length of graph_1 :", f1(adjacencyMatrix_case_2))
print("The diameter of graph_1 : ", f2(adjacencyMatrix_case_2))
print("The number of links of graph 1:", f3(adjacencyMatrix_case_2))
print("Check if graph 1 is connected :", checkConnected(adjacencyMatrix_case_2))

def mutation_addLink(adjacencyMatrix:list):
    #check if it is fully connected graph

    N = len(adjacencyMatrix)
    fc = True
    for i in range(N):
        for j in range(N):

            if i == j:
                continue

            if adjacencyMatrix[i][j] == 0:
                fc = False
    
    if fc:

        # print("The graph is already Fully Connected. No new link will be added to the graph !")
        return adjacencyMatrix
    #add a link between these random node
    #check if the link was absent before first

    v1 = random.randint(0, N - 1)
    v2 = random.randint(0, N - 1)
    while v2 == v1 or adjacencyMatrix[v1][v2] == 1:
        v1 = random.randint(0, N - 1)
        v2 = random.randint(0, N - 1)

    adjacencyMatrix = addEdge(adjacencyMatrix, v1, v2)


    # print("Addition Success : added a random link to this graph!")
    return  adjacencyMatrix

def mutation_removeLink(adjacencyMatrix:list):

    N = len(adjacencyMatrix)

    num_links = f3(adjacencyMatrix)

    # when number of links is less than number of Verices, there must be no link that could be removed and still stay connected
    if num_links < N: 

        # print("Removal Failure : Can not remove any link from this graph !")

        return adjacencyMatrix

    #remove a randomly choosen link, provided that the graph stays connected

    NotConnected = True

    while NotConnected:

        v1 = random.randint(0, N - 1)
        v2 = random.randint(0, N - 1)

        # if two verices are the same, random again , or if there is no link between these two veritce, do the randomization again

        if v1 == v2 or adjacencyMatrix[v1][v2] == 0:

            continue

        # try remove the random selected edge

        adjacencyMatrix = removeEdge(adjacencyMatrix, v1, v2)

        # if the graph after removal is still connected , then update the status of NotConnected and exit the while loop

        if checkConnected(adjacencyMatrix):

            NotConnected = False

        else:

            adjacencyMatrix = addEdge(adjacencyMatrix, v1, v2)

    # print("Removel Success: removed a random link from this graph!")

    return adjacencyMatrix


 
def Mutation(adjacencyMatrix:list):
    adjacencyMatrix= mutation_removeLink(adjacencyMatrix)
    
    adjacencyMatrix= mutation_addLink(adjacencyMatrix)


    return adjacencyMatrix

print(adjacencyMatrix_star)
print(mutation_removeLink(adjacencyMatrix_star))
print(mutation_addLink(adjacencyMatrix_star))

print()
print("--------------------------------Question 3(a) ---------------------------------")
print()
print("The original adjacency matrix of Line graph with 6 Node: \n", adjacencyMatrix_line)

print()
print("Apply Mutation of randomly Adding link to line graph and results in adjacencyMatrix:\n",mutation_addLink(adjacencyMatrix_line))
print("Results: Added a random link to line graph")
print()
print("The original adjacency matrix of Even Ring graph with 6 Node: \n", adjacencyMatrix_evenRing)
print()
print("Apply Mutation of randomly Adding link to Even Ring graph and results in adjacencyMatrix:\n",mutation_addLink(adjacencyMatrix_evenRing))
print("Results: Added a random link to line graph")
print()
print("The original adjacency matrix of star graph with 5 Node: \n", adjacencyMatrix_star)
print()
print("Apply Mutation of randomly Adding link to star graph and results in adjacencyMatrix:\n",mutation_addLink(adjacencyMatrix_star))
print("Results: Added a random link to line graph")
print()
print("The original adjacency matrix of Fuly Connected graph with 5 Node: \n", adjacencyMatrix_fullyConnected)
print()
print("Apply Mutation of randomly Adding link to Fully Cnnected graph and results in adjacencyMatrix:\n",mutation_addLink(adjacencyMatrix_fullyConnected))
print("Results: No mutation of adding link to fully connected graph ")
print()
adjacencyMatrix_line= [
    [0, 1, 0, 0, 0, 0],
    [1, 0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0, 1],
    [0, 0, 0, 0, 1, 0]
]

adjacencyMatrix_oddRing =[
    [0, 1, 0, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0, 0],
    [0, 1, 0, 1, 0, 0, 0],
    [0, 0, 1, 0, 1, 0, 0],
    [0, 0, 0, 1, 0, 1, 0],
    [0, 0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 0, 1, 0]
]
adjacencyMatrix_evenRing =[
    [0, 1, 0, 0, 0, 1],
    [1, 0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0, 0],
    [0, 0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0, 1],
    [1, 0, 0, 0, 1, 0]
]
adjacencyMatrix_star =[

    [0, 0, 0, 0, 1], 
    [0, 0, 0, 0, 1],
    [0, 0, 0, 0, 1], 
    [0, 0, 0, 0, 1],
    [1, 1, 1, 1, 0]
]
print()
print("--------------------------------Question 3(b) ---------------------------------")
print()
print("The original adjacency matrix of Line graph with 6 Node: \n", adjacencyMatrix_line)
print()
print("Mutation of randomly remove a link to line graph and results in adjacencyMatrix:")
print(mutation_removeLink(adjacencyMatrix_line))

print("The original adjacency matrix of Ring graph with 6 Node: \n", adjacencyMatrix_evenRing)
print()
print(" Mutation of randomly remove a link to Ring graph and results in adjacencyMatrix:")
print(mutation_removeLink(adjacencyMatrix_evenRing))

print("The original adjacency matrix of Star graph with 6 Node: \n", adjacencyMatrix_star)
print()
print("Mutation of randomly remove a link to Star graph and results in adjacencyMatrix:")
print(mutation_removeLink(adjacencyMatrix_star))

print("The original adjacency matrix of Fully Connected graph with 6 Node: \n", adjacencyMatrix_fullyConnected)
print()
print("Mutation of randomly remove a link to Fully Connected graph and results in adjacencyMatrix:")
print(mutation_removeLink(adjacencyMatrix_fullyConnected))

# Test Case for 3(c) - Random Rewiring

test_graph_1 = [
    [0, 0, 0, 1, 1],
    [0, 0, 0, 1, 1],
    [0, 0, 0, 1, 0],
    [1, 1, 1, 0, 0],
    [1, 1, 0, 0, 0]
]

test_graph_2 = [
    [0, 1, 0, 0, 0, 1, 0],
    [1, 0, 1, 1, 0, 1, 0],
    [0, 1, 0, 0, 0, 0, 0],
    [0, 1, 0, 0, 1, 1, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [1, 1, 0, 1, 0, 0, 1],
    [0, 0, 0, 0, 0, 1, 0]
]

test_graph_3 = [
    [0, 1, 1, 0, 0],
    [1, 0, 1, 0, 1],
    [1, 1, 0, 0, 1],
    [0, 0, 0, 0, 1],
    [0, 1, 1, 1, 0]
]

def plot_mutation(adj_matrix, case):


    n = len(adj_matrix)
    plt.figure(figsize = (20, 10))

    x = []
    y = []
    while len(x) != n:

        x_i = random.randint(0, 50)
        y_i = random.randint(0, 50)

        if x_i in x and y_i in y: # if the point is already generated, random agaiin
            continue

        x.append(x_i)
        y.append(y_i)

    # plot the randomly generated graph
    plt.subplot()
    plt.plot(x, y, 'r.')
    plt.title(f"case_{case}_before_mutation")

    # connect the vertices using adj matrix

    for i in range(len(x) - 1):

        x_i = x[i]
        y_i = y[i]

        for j in range(i + 1, len(x)):
            if adj_matrix[i][j] == 1:
                x_j = x[j]
                y_j = y[j]
                start = (x_i, x_j)
                end = (y_i, y_j)
                plt.plot(start, end)

    plt.savefig(f"case_{case}_before_mutation.png")
    plt.show()

    plt.subplot()
    plt.plot(x, y, 'r.')
    plt.title(f"case_{case}_after_mutation")
    adj_matrix = Mutation(adj_matrix)

    for i in range(len(x) - 1):

        x_i = x[i]
        y_i = y[i]

        for j in range(i + 1, len(x)):
            if adj_matrix[i][j] == 1:
                x_j = x[j]
                y_j = y[j]
                start = (x_i, x_j)
                end = (y_i, y_j)
                plt.plot(start, end)

    plt.savefig(f"case_{case}_after_mutation.png")
    plt.show()

    


print()
print("--------------------------------Question 3(c) ---------------------------------")
print()
print("--------------------------------3(c) Test Case 1 ---------------------------------")
print()
print("The original adjacency matrix of Test Graph 1 with 5 Node: \n", test_graph_1)
print()
plot_mutation(test_graph_1, 1)
print("Rewiring Mutation on test graph 1 :")
# Mutation(test_graph_1)
print("Resulting Graph after operation:")
print(test_graph_1)
print()
print("**********" * 10)
print()
print("--------------------------------3(c) Test Case 2 ---------------------------------")
print()
print("The original adjacency matrix of Test Graph 2 with 5 Node: \n", test_graph_2)
print()
plot_mutation(test_graph_2, 2)
print("Rewiring Mutation on test graph 2 :")
# Mutation(test_graph_2)
print("Resulting Graph after operation:")

print(test_graph_2)
print()
print("**********" * 10)
print()
print("--------------------------------3(c) Test Case 3 ---------------------------------")
print()
print("The original adjacency matrix of Test Graph 3 with 6 Node: \n", test_graph_3)
print()

print("Rewiring Mutation on test graph 3 :")
Mutation(test_graph_3)
print("Resulting Graph after operation:")

print(test_graph_3)
print("**********" * 10)
print()




    
# def f2(G):
    
#     diameter = 0
#     for i in range(G.N):
#         for j in range(G.N):
#             dist =  G.shortestPath(i, j)
#             diameter = dist if dist > diameter else diameter

#     return diameter


 
# def Mutation(G):
#     G = mutation_addLink(G)
#     G = mutation_removeLink(G)
#     return G



class EvolutionaryAlgorithn():

    def __init__(self, population, generation, N, p1, p2):
        self.size = population
        self.max_iter = generation
        self.N = N
        self.p1 = p1
        self.p2 = p2
        self.p3 = 1 - p1 - p2
        self.solutions = [[[ 0 for _ in range(self.N)] for _ in range(N)] for _ in range(self.size)]
        self.fitness = [float("INF") for _ in range(self.size)]

    def intialize_graphs(self):
        # necessary to intialize all graph in popultation by adding random links
        for adjMatrix in self.solutions:
            adjMatrix = self.connectGraph(adjMatrix)

    def connectGraph(self, matrix):
         # randomly choose two vertice and add link to form a inital graph(need to be connected)

        while not checkConnected(matrix):

            v1 = random.randint(0, self.N- 1)
            v2 = random.randint(0, self.N - 1)

            if v1 == v2:
                continue

            matrix = addEdge(matrix, v1, v2)

        return matrix


    def cal_fitness(self, solutions):
        # use Average Path Length as fitness function 
        fitness = [0 for _ in range(self.size)]
        for i in range(self.size):

            # use f(2) - f(1) as fitness function

            fitness[i] = f2(solutions[i]) - f1(solutions[i])

        return fitness

    def mutate(self, generation):
        #apply mutations to solutions with pre-defined hyperparameter p1, p2, p3
        candidates_new = copy.deepcopy(self.solutions)
        candidates_prev = copy.deepcopy(self.solutions)
        fitness_prev = copy.deepcopy(self.fitness)
        for i in range(self.size):
            rand_p1 = random.random()
            rand_p2 = random.random()
            rand_p3 = random.random()

            if rand_p1 <= self.p1:
                candidates_new[i]  = mutation_addLink(candidates_new[i])

            if rand_p2 <= self.p2:
                candidates_new[i]  = mutation_removeLink(candidates_new[i])

            if rand_p3 <= self.p3:
                candidates_new[i]  = Mutation(candidates_new[i])

        #calculate the fitness of new solutions after mutations, and compare to last generation to keep best fitness 

        fitness_new = self.cal_fitness(candidates_new)
        
        print("----------------------Generation", generation,"----------------------")
        # print("New  candidates's fitness: \n",fitness_new)
        # print("Current solutions's fitness: \n",fitness_prev)

        for pos in range(self.size):

            # compare the min fitness in new candidates with previous solutions

            best_new_fit = max(fitness_new)
            best_prev_fit = max(fitness_prev)
            # replace the new solution into population
            if best_new_fit > best_prev_fit:

                # find the index of solution with best fitness

                idx = fitness_new.index(best_new_fit)
                self.solutions[pos] = copy.deepcopy(candidates_new[idx])
                self.fitness[pos] = best_new_fit
                fitness_new[idx] = float("-INF")

            else:
                idx = fitness_prev.index(best_prev_fit)
                self.solutions[pos] = copy.deepcopy(candidates_prev[idx])
                self.fitness[pos] = best_prev_fit
                fitness_prev[idx] = float("-INF")


        print("New generation fitness: \n", self.fitness)

    def evo(self):
        
        # intialization

        self.intialize_graphs()
        self.fitness = self.cal_fitness(self.solutions)

        for i in range(self.max_iter):

            self.mutate(i)
            print()

EA = EvolutionaryAlgorithn(100, 100, 12, 0.2,0.3)
EA.evo()



# Question 5 code

# Question 5(a)

# Assumptions: 
# f1 : transpotation cost
# f2 : network maintenance costs 
# f2 : complaint + refund cost

# Use a linearly weighted fitness a1f1 + a2f2 + a3f3 = fw and minimize fw for three qualititaively different choices of the weights

# Three weight choices
w_1 = [0.6, 0.2, 0.2] # f1 is more imporant 
w_2 = [0.2, 0.6, 0.2] # f2 is more imporant 
w_3 = [0.2, 0.2, 0.6] # f3 is more imporant 


class EvoAlgorithm_TransportationNetwork():
    
    def __init__(self, population, generation, N, weights, p1, p2):

        self.a1 = weights[0]
        self.a2 = weights[1]
        self.a3 = weights[2]

        self.population = population
        self.max_iter = generation
        self.N = N
        self.p1 = p1
        self.p2 = p2
        self.p3 = 1 - p1 - p2
        self.solutions = [[[ 0 for _ in range(self.N)] for _ in range(N)] for _ in range(self.population)]
        self.fitness = [float("INF") for _ in range(self.population)]


    def intialize_graphs(self):

        # necessary to intialize all graph in popultation by adding random links

        for adjMatrix in self.solutions:
            adjMatrix = self.connectGraph(adjMatrix)

    def connectGraph(self, matrix):

         # randomly choose two vertice and add link to form a inital graph(need to be connected)

        while not checkConnected(matrix):

            v1 = random.randint(0, self.N- 1)
            v2 = random.randint(0, self.N - 1)

            if v1 == v2:
                continue

            matrix = addEdge(matrix, v1, v2)

        return matrix

    def calc_fitness(self, solutions):

        # f(w) - which equals a1f1 + a2f2 + a3f3 - is the fitness fucntion in this case

        fitness = [0 for _ in range(self.population)]

        for i in range(self.population):

            # use f(2) - f(1) as fitness function

            fitness[i] = self.a1 * f1(solutions[i]) + self.a2 * f2(solutions[i]) +  self.a3 * f3(solutions[i])

        return fitness


    def mutate(self):

        #apply mutations to solutions with pre-defined hyperparameter p1, p2, p3

        candidates_new = copy.deepcopy(self.solutions)
        candidates_prev = copy.deepcopy(self.solutions)
        fitness_prev = copy.deepcopy(self.fitness)

        for i in range(self.population):

            rand_p1 = random.random()
            rand_p2 = random.random()
            rand_p3 = random.random()

            if rand_p1 <= self.p1:
                candidates_new[i]  = mutation_addLink(candidates_new[i])

            if rand_p2 <= self.p2:
                candidates_new[i]  = mutation_removeLink(candidates_new[i])

            if rand_p3 <= self.p3:
                candidates_new[i]  = Mutation(candidates_new[i])

        return candidates_new


    def replacement(self, candidates_new):

        fitness_new = self.calc_fitness(candidates_new)  
        fitness_prev = copy.deepcopy(self.fitness) 
        candidates_prev = copy.deepcopy(self.solutions)

        # print("New  candidates's fitness: \n",fitness_new)
        # print("Current solutions's fitness: \n",fitness_prev)

        for pos in range(self.population):

            # compare the min fitness in new candidates with previous solutions

            # the objective of this optimization is to minimize f(w)
            # thus take the minValue everytime into the solutions for new generation

            best_new_fitness = min(fitness_new)
            best_prev_fitness = min(fitness_prev)

            # replace the new solution into population
            # in this way, the solutions in new generation is sorted automatically 
            if best_new_fitness < best_prev_fitness:

                # find the index of solution with best fitness
                idx = fitness_new.index(best_new_fitness)
                self.solutions[pos] = copy.deepcopy(candidates_new[idx]) # replace the solutions in population with the new fit solution
                self.fitness[pos] = best_new_fitness
                fitness_new[idx] = float("INF")

            else:
                idx = fitness_prev.index(best_prev_fitness)
                self.solutions[pos] = copy.deepcopy(candidates_prev[idx]) # replace the solutions in population with the new fit solution
                self.fitness[pos] = best_prev_fitness
                fitness_prev[idx] = float("INF")


        print("New Generation Fitness: \n", self.fitness)

    def evo(self):
        
        # intialization

        self.intialize_graphs()
        self.fitness = self.calc_fitness(self.solutions)

        for i in range(self.max_iter):

            print("-------------------------Generation", i, "------------------------------")
            new_solutions = self.mutate()
            self.replacement(new_solutions)


# ea_5 = EvoAlgorithm_TransportationNetwork(100, 80, 9, w_1, 0.2,0.3)
# ea_5.evo()

# ea_5 = EvoAlgorithm_TransportationNetwork(100, 80, 9, w_2, 0.2,0.3)
# ea_5.evo()

# ea_5 = EvoAlgorithm_TransportationNetwork(100, 80, 9, w_3, 0.2,0.3)
# ea_5.evo()


# ----------------------------------------------- Question 5(b) ---------------------------------------------------------

class Solution():

    def __init__(self, N):

        self.adjacencyMatrix = [[ 0 for _ in range(self.N)] for _ in range(N)] # adjacency matrix of the solution
        self.dominated_count = 0 # the number of solutions that dominates this solution
        self.dominates = [] # the solutions that this solution dominates 
        self.crowdDistance = 0 # the crowd distance to represent the level of spread

        self.adjacencyMatrix = self.initializeGraph()

        

    def initializeGraph(self):

         # randomly choose two vertice and add link to form a inital graph(need to be connected)

        while not checkConnected(self.adjacencyMatrixmatrix):

            v1 = random.randint(0, self.N- 1)
            v2 = random.randint(0, self.N - 1)

            if v1 == v2:
                continue

            self.adjacencyMatrix = addEdge(self.adjacencyMatrixmatrix, v1, v2)

        return self.adjacencyMatrix


class NSGA_II():

    def __init__(self, population, generation, N, p1, p2):

        self.size= population
        self.max_iter = generation
        self.N = N
        self.populations = [[[ 0 for _ in range(self.N)] for _ in range(N)] for _ in range(self.size)]
        self.p1 = p1
        self.p2 = p2
        self.p3 = 1- p2 - p1



    def intialize_graphs(self):

        # necessary to intialize all graph in popultation by adding random links

        for adjMatrix in self.populations:
            adjMatrix = self.connectGraph(adjMatrix)

    def connectGraph(self, matrix):

         # randomly choose two vertice and add link to form a inital graph(need to be connected)

        while not checkConnected(matrix):

            v1 = random.randint(0, self.N- 1)
            v2 = random.randint(0, self.N - 1)

            if v1 == v2:
                continue

            matrix = addEdge(matrix, v1, v2)

        return matrix

    def updateObjectiveValues(self, solutions):

        f1_value = [0 for _ in range(len(solutions))]

        f2_value = [0 for _ in range(len(solutions))]

        f3_value = [0 for _ in range(len(solutions))]

        for i in range(self.size):

            f1_value[i] = f1(solutions[i])

            f2_value[i] = f2(solutions[i])

            f3_value[i] = f3(solutions[i])


        res = [f1_value, f2_value, f3_value]

        return res




    
    def Non_dominated_sorting(self, solutions):


        dominates = [ [] for _ in range(len(solutions))]
        dominated_counts = [0 for _ in range(len(solutions))]
        rank = [0 for _ in range(len(solutions))]

        front = [[]]

        for i in range(len(solutions)):

            for j in range(i, len(solutions)): # avoid repetition of pairs

                if i == j:
                    continue

                if self.Dominate(i, j, solutions):
                    dominates[j].append(i)
                elif self.Dominate(j, i, solutions):
                    dominated_counts[j] += 1

        for i in range(len(solutions)):

            if dominated_counts[i] == 0: # find all solutions that is not dominated by other
                front[0].append(i) # keep i in the non-dominated front Front front_idx

        k = 0
        while (front[k] != []):

            Q = []

            for p in front[k]: # take all solutions in particular front
                for s in dominates[p]:

                    dominated_counts[s] -= 1
                    if dominated_counts == 0:
                        rank[s] = k + 1

                    if s not in Q:
                        Q.append(s)

            k += 1

            front.append(Q)

        if front[len(front) -1] == []:
            del front[len(front) - 1]

        return front

    def Dominate(self, i, j, populations) -> bool:

        f1_i = f1(populations[i])
        f2_i = f2(populations[i])
        f3_i = f3(populations[i])

        f1_j = f1(populations[j])
        f2_j = f2(populations[j])
        f3_j = f3(populations[j])

        condition_1 = f1_j <= f1_i and f2_j <= f2_i and f3_j <= f3_i
        condition_2 = f1_j < f2_i or f2_j < f2_i or f3_j < f3_i

        if condition_1 and condition_2: # when both condition satisfy, means solution J dominate solution i
            return True

        return False


    def sort_solutions(self, front_solutions,  f_values):

        objective_array = [0 for _ in range(len(front_solutions))]


        for i in range(len(front_solutions)):

            index = front_solutions[i]

            objective_array[i] = f_values[index]

        # sort by the objective function value

        sorted_list = []

        while (len(sorted_list) != len(objective_array)):

            minValue = min(objective_array)
            min_idx = objective_array.index(minValue)
            sorted_list.append(min_idx)
            objective_array[min_idx] = float("INF")

        return sorted_list


    def crowdingDistance(self, front, f1, f2, f3):

        distance = [0 for _ in range(len(front))]

        num_objective = 3

        distance[0] = float("INF")
        distance[len(distance) - 1] = float("INF")

        for objective in range(num_objective):

            for j in range(1, len(distance) - 1):

                if objective == 0:

                    sorted_front_solutions = self.sort_solutions(front,  f1)
                    if max(f1) - min(f1) != 0:
                        distance[j] += (f1[sorted_front_solutions[j + 1]] - f1[sorted_front_solutions[j - 1]]) / (max(f1) - min(f1))

                elif objective == 1:

                    sorted_front_solutions = self.sort_solutions(front, f2)
                    if max(f1) - min(f1) != 0:
                        distance[j] += (f2[sorted_front_solutions[j + 1]] - f2[sorted_front_solutions[j - 1]]) / (max(f2) - min(f2))

                else:
                    sorted_front_solutions = self.sort_solutions(front,  f3)
                    if max(f1) - min(f1) != 0:
                        distance[j] += (f3[sorted_front_solutions[j + 1]] - f3[sorted_front_solutions[j - 1]]) / (max(f3) - min(f3))

        return distance

    def mutate(self):

        #apply mutations to solutions with pre-defined hyperparameter p1, p2, p3

        candidates_new = copy.deepcopy(self.populations)
        candidates_prev = copy.deepcopy(self.populations)

        for i in range(self.size):

            rand_p1 = random.random()
            rand_p2 = random.random()
            rand_p3 = random.random()

            if rand_p1 <= self.p1:
                candidates_new[i]  = mutation_addLink(candidates_new[i])

            if rand_p2 <= self.p2:
                candidates_new[i]  = mutation_removeLink(candidates_new[i])

            if rand_p3 <= self.p3:
                candidates_new[i]  = Mutation(candidates_new[i])

        return candidates_new



    def sort_crowdDistance(self, front, crowd_distance):



        distance = crowd_distance[:]
        sorted_front = []

        while (len(sorted_front) != len(distance)):

            maxValue = max(distance)
            max_idx = distance.index(maxValue)
            sorted_front.append(front[max_idx])
            distance[max_idx] = float("-INF")

        return sorted_front

    def nsga_main(self):


        self.intialize_graphs()

        gen = 0

        while gen < self.max_iter:

            print("--------------------------Generation", gen, "-------------------------------------------------")

            objective_values = self.updateObjectiveValues(self.populations)
            f1_values = objective_values[0]
            f2_values = objective_values[1]
            f3_values = objective_values[2]

            # get different fronts 

            non_dominant_sorted_front = self.Non_dominated_sorting(self.populations)
            print(non_dominant_sorted_front[0])

            crowding_distances = []
            for front in range(len(non_dominant_sorted_front)):
                crowding_distances.append(self.crowdingDistance(non_dominant_sorted_front[front][:], f1_values, f2_values, f3_values))

            candidates = self.populations[:]

            # mutate 
            candidates += self.mutate()

            objective_values = self.updateObjectiveValues(candidates)
            f1_values_2 = objective_values[0]
            f2_values_2 = objective_values[1]
            f3_values_2 = objective_values[2]

            new_non_dominant_sorted_front = self.Non_dominated_sorting(candidates)
            print(new_non_dominant_sorted_front[0])

            new_crowding_distances =[]
            for front in range(len(new_non_dominant_sorted_front)):
                new_crowding_distances.append(self.crowdingDistance(new_non_dominant_sorted_front[front][:], f1_values_2, f2_values_2, f3_values_2))

            new_population = []
            i = 0
            while len(new_population) + len(new_non_dominant_sorted_front[i]) < self.size:

                for pos in new_non_dominant_sorted_front[i]:
                    new_population.append(candidates[pos])

                i += 1
            sorted_front = new_non_dominant_sorted_front[i]
            crowd_sort_front = new_crowding_distances[i]

            sorted_front = self.sort_crowdDistance(sorted_front, crowd_sort_front)

            i = 0
            while len(new_population) < self.size:

                new_population.append(candidates[sorted_front[i]])

            self.populations = new_population[:]


            gen += 1

            print(f1_values)
            print(f2_values)
            print(f3_values)


            

# nsga_II = NSGA_II(50, 50, 8, 0.2, 0.3)
# nsga_II.nsga_main()








        







        


    















