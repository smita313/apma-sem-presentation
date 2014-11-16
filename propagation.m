function [B, b] = propagation(bk, ak, aik, a, c, omega)
extShock = 0; % calculate external shock

for i = 1:length(c)
    for j = 1:length(c)
        if (i==j)
            c(i,j) = 0;
        end
    end
end

for i = 1:length(ak)
    extShock = extShock + bk(i) * ak(i);
end

t = 1;
b = zeros(1, length(c));
condition = true;
while(condition)
    lambda = bk * aik + b * c; % compute lambda
    B = [];
    b = [];  
    v = [];
    
    for i = 1:length(lambda) % compute B and b
        r = 0;
        d = 0;
        for j = 1:length(c)            
            r = r + c(j,i);
            d = d + c(i,j);
        end
        vi = a(1,i) + r + d;
        v = [v, vi];
        activation = min(lambda(i)/vi, 1);
        insolvency = max(0, (lambda(i) - vi)/d);
        B = [B, activation];
        b = [b, insolvency];
    end
    
    if(length(omega) >= 2)
        %b = searchCyclesAndSetValues(b, c);
    end
    
    Bv = 0;
    for i = 1:omega
        Bv = Bv + B(i) * v(i);
    end
    if( t > 2)%Bv >= extShock)
        condition = false;
    end
    fprintf('Iteration %d:\n', t);
    fprintf('[B]:' );
    disp(B);
    fprintf('[b]:' );
    disp(b);
    t = t + 1;
end
