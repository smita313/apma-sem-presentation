function [B, b] = propagation(bk, ak, aik, a, c, omega)

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

for i = 1:length(c)
    for j = 1:length(c)
        if (i==j)
            c(i,j) = 0;
        end
    end
end

extShock = 0; % calculate external shock
for i = 1:length(ak)
    extShock = extShock + bk(i) * ak(i);
end

t = 1;
b = zeros(1, length(c));
condition = true;
while(condition)
    lambda = bk * aik + b * c; % Step 1: compute lambda
    B = [];
    b = [];  
    v = [];
    
    for i = 1:length(lambda) % Step 2: compute B and b
        r = 0;
        d = 0;
        for j = 1:length(c)            
            r = r + c(j,i);
            d = d + c(i,j);
        end
        v = [v, a(i) + r - d];
        activation = min(lambda(i)/v(i), 1);
        insolvency = max(0, (lambda(i) - v(i))/d);
        B = [B, activation];
        b = [b, insolvency];
    end
    
    if(omega >= 2) % Step 3: Find all cycles and set bi = 1 if nodes in cycle       
        b = searchCyclesAndSetValues(b, graph); % have no debt with nodes outside cycle
    end
    
    flowToSink = 0;
    for i = 1:omega
        flowToSink = flowToSink + B(i) * v(i);
    end
    if (flowToSink >= extShock || t > 20) % Step 4: Check equality
        condition = false;
    end
    
    fprintf('Iteration %d:\n', t);
    fprintf('[B]:' );
    disp(B);
    fprintf('[b]:' );
    disp(b);
    fprintf('flowToSink: %d\n', flowToSink);
    fprintf('externalShock: %d\n\n', extShock);
    t = t + 1;
end
