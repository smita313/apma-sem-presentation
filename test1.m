function [B, b] = test1()
bk = [0.4, 0.2, 0.3];
ak = [400000, 300000, 500000];
aik = [100000, 100000, 100000, 1000000, 0; 
    50000, 50000, 100000, 50000, 50000; 
    100000, 100000, 100000, 100000, 100000];
a = [200000, 200000, 200000, 200000, 200000];
c = [0, 20000, 0, 0, 0;
    0, 0, 10000, 0, 50000;
    10000, 0, 0, 50000, 50000;
    0, 10000, 0, 0, 0;
    10000, 0, 0, 0, 0];
[B, b] = propagation(bk,ak,aik,a,c,5);
end