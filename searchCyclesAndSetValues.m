function [b] = searchCyclesAndSetValues(b, c)
S = [];
E = [];
for i = 1:length(c)
    for j = 1:length(c)
        if(c(i,j) > 0)
            S = [S, i];
            E = [E, j];
        end
    end
end

graph = sparse(S, E, true, length(c), length(c));
view(biograph(graph));

connections = {};
for i = 1:length(graph)
    distances = bfs(graph,i);
    distanceIs1 = [];
    for j = 1:length(distances)
        if(distances(j) == 1)
            distanceIs1 = [distanceIs1, j];
        end        
    end
    connections{i} = distanceIs1;
end

[~, cycles] = find_elem_circuits(graph);
dontChangeValue = [];
for cycle = cycles
    for connection  = connections
        conn = cell2mat(connection);
        for c = conn
            cyc = cell2mat(cycle);
            if(ismember(c, cyc) == 0)
                dontChangeValue = [dontChangeValue, conn];
            end
        end
        
    end
end

for i = 1:length(b)
    if(ismember(i, dontChangeValue) == 0)
        b(i) = 1;
    end
end
end
