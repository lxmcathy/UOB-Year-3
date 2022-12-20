function pos = mutation_remove(G,seed)
m_size=length(G); %matrix size
rng(seed);
pos=G;  
    while true
        ran_i=0;
        ran_j=0;
        while true
    
            ran_i=randi(m_size);
            ran_j=randi(m_size);
            if ran_i ~= ran_j
                break
            end
        end
        %add
        if pos(ran_i,ran_j)==1
        pos(ran_i,ran_j)=0;
        pos(ran_j,ran_i)=0;
        if  max(conncomp(digraph(pos))) ~= 1
            pos = G;
            continue
        else
            break
        end
        end
        %conncted
    end
    %G = graph(pos);
    %plot(G)
end