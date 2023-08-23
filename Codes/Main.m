clc
clear

[n, m, p, car_loc, station_loc, passenger_loc, speed, capacity, car_charge, station_chargerate] = input_data;

lb=ones(1,2*n);
ub=ones(1,2*n);

for i=1:2*n
    if i<n+1
        ub(i)=m;
    else
        ub(i)=n;
    end
end

rng(1,'twister') 

intcon=ones(1,2*n);
for i=1:2*n
    intcon(i)=i;
end

options = optimoptions('ga', 'MaxGenerations',10);
[x,fval,exitflag] = ga(@func,2*n,[],[],[],[],lb,ub,[],intcon,options);
x
fval
