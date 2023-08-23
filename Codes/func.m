function f= func(x)
global inp_idx s_num
[n, m, p, car_loc, station_loc, passenger_loc, speed, capacity, car_charge, station_chargerate] = input_data;

penalty=0;          %So that no two vehicles are assigned to the same passenger
t1=0;
t2=0;
t3=0;

%t1
for i=1:n
    t1=t1+time(car_loc(i,1),car_loc(i,2),station_loc(x(i),1),station_loc(x(i),2),speed);
end

%W    Calculating the waiting time for each vehicle in that station
w=0;
for s_num=1:m

    ct=0;
    for k=1:n
        if x(k)==s_num
            ct=ct+1;
        end
    end

    inp_idx=ones(1,ct);

    c=1;
    for i=1:n
        if x(i)==s_num
            inp_idx(c)=i;        %for storing nth vehicle in that order [1,4,5]
            c=c+1;
        end
    end

    lb_dash=ones(1,ct);
    ub_dash=ct*ones(1,ct);
    intcon_dash=1:ct;
    prob = @func2;

    if ct>1
        options = optimoptions('ga', 'MaxGenerations', 2);
        [y,yfval,yexitflag] = ga(prob,ct,[],[],[],[],lb_dash,ub_dash,[],intcon_dash,options);
        y
        yfval
        w=w+yfval;

    end
end

%tqr- Total Charging time
tqr=0;
for i=1:n
    tqr=tqr+(capacity-car_charge(i))/station_chargerate(x(i));
end

%t3
for i =n+1:2*n
    t3=t3+time(station_loc(x(i-n),1),station_loc(x(i-n),2),passenger_loc(x(i),1),passenger_loc(x(i),2),speed);
end

%penalty
cnt=0;

for i=1:n
    for j=n+1:2*n
        if x(j)==i
            cnt=cnt+1;
            break
        end
    end
end

cnt=n-cnt;
penalty=cnt*10^5;

t2=w+tqr;
t1;
t3;
tqr;
f=t1+t2+t3+penalty        %This is our Objective function which we want to minimize
x