function b = searchCyclesAndSetValues(b, c)
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

graph = sparse(S,E,true, length(c), length(c));
view(biograph(graph));
[S,C] = graphconncomp(graph);
% search for cycles in omega and set bi = 1 if
% cycle has no debts with outside nodes
end
