function [b] = searchCyclesAndSetValues(b, graph)
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
visited = false(1,length(graph));
for cycle = cycles
    cyc = cell2mat(cycle);
    for node = cyc
        visited(node) = true;
        connection = connections{node};
        for c = connection
            if(~ismember(c, cyc))
                dontChangeValue = [dontChangeValue, node];
            end
        end        
    end
end

for i = 1:length(b)
    if(~ismember(i, dontChangeValue) && visited(i))
        b(i) = 1;
    end
end
end
