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

%rng(1,'twister') 

intcon=ones(1,2*n);
for i=1:2*n
    intcon(i)=i;
end

num=50;
num_itr=1:num;
Fval=ones(1,num);
j=1;
for k=1:num
    rng(1,'twister')
    options = optimoptions('ga', 'MaxGenerations',k);
    [x,fval,exitflag] = ga(@func,2*n,[],[],[],[],lb,ub,[],intcon,options);
    Fval(j)=fval;
    j=j+1;
end

plot(num_itr, Fval, 'ro-') % 'ro-' specifies red circles connected by a solid line
xlabel('num_itr')
ylabel('Time Value')
title('Plot')
x
fval
Fval
