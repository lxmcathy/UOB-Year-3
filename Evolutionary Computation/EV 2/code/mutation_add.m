function pos = mutation_add(G,seed)
%load('ring.mat');
m_size=length(G); %matrix size
pos=G;
count = 0;
check = true;
if sum(pos,'all') == (m_size*m_size - m_size)
            check = false;
end
    while check
        
        rng(seed+count);
        count = count + 1;
        ran_i=0;
        ran_j=0;
        while true
            count = count + 1;
            rng(seed+count+1);
            ran_i=randi(m_size);
            ran_j=randi(m_size);
            
            if ran_i ~= ran_j
                break
            end
        end
        %add
        if pos(ran_i,ran_j)==0
        pos(ran_i,ran_j)=1;
        pos(ran_j,ran_i)=1;
        break 
        end
        %conncted
    end
    %G = graph(pos);
    %plot(G)
    connection = conncomp(digraph(pos));
end
