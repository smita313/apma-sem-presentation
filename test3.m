function [B, b] = test3()
bk = [0.8, 0.6, 0.2];

ak = [500000, 300000, 500000];

aik = [100000, 100000, 100000, 100000, 100000; 
       50000, 50000, 100000, 50000, 50000; 
       100000, 100000, 100000, 100000, 0];

a = [300000, 100000, 100000, 300000, 100000];

c = [0, 50000, 0, 0, 0;
     0, 0, 0, 60000, 0;
     0, 60000, 0, 0, 20000;
     0, 0, 80000, 0, 0;
     0, 0, 0, 40000, 0];
 
[B, b] = propagation(bk,ak,aik,a,c,5);
end