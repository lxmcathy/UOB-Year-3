function pos=Mutation_re(G,seed)

pos = mutation_remove(mutation_add(G,seed),seed);

connection = conncomp(digraph(pos));
disp(connection);
end