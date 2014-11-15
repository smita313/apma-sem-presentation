function [B, b] = propagation(bk, ak, a, c, omega)
b = zeros(1, length(c));
extShock = 0;

for i = 1:length(ak)
    extShock = extShock + bk(1, i) * ak(1, i);
end
condition = true;
while(condition)
    lambda = bk * ak + b * c; % compute lambda
    B = [];
    b = [];  
    v = [];
    
    for i = 1:length(lambda) % compute B and b
        r = 0;
        d = 0;
        for j = 1:length(c)
            if(i ~= j)
                r = r + c(j,i);
                d = d + c(i,j);
            end
        end
        vi = a(1,i) + r + d;
        v = [v, vi];
        activation = min(lambda(1,i)/vi, 1);
        insolvency = max(0, (lambda(1,i) - vi)/d);
        B = [B, activation];
        b = [b, insolvency];
    end
    
    if(length(omega) >= 2)
        % search for cycles
        % set bi
    end
    
    Bv = 0;
    for i = 1:length(omega)
        Bv = Bv + B(1, i) * v(1, i);
    end
    if(Bv >= extShock)
        condition = false;
    end
end