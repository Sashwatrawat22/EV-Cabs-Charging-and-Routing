function f2= func2(y)       %import inp_idx and s_num= station number
global inp_idx s_num
[n, m, p, car_loc, station_loc, passenger_loc, speed, capacity, car_charge, station_chargerate] = input_data;

T=0;                             %Total waiting time for this station
t=0;                            %waiting time for ith vehicle
t_wait=0;
penalty2=0;

size=length(inp_idx);

if size==0 || size==1
    T=0;
else
    unique_arr = unique(y);
    if length(unique_arr) == size
        for i=1:size
            if i==1
                continue;
            end

            prev=y(i-1);        %n-1th vehicle ith position
            curr=y(i);

            tic_prev=time(car_loc(inp_idx(prev),1),car_loc(inp_idx(prev),2),station_loc(s_num,1),station_loc(s_num,2),speed);
            tc_prev=(capacity-car_charge(inp_idx(prev)))/station_chargerate(s_num);
            tic_cur=time(car_loc(inp_idx(curr),1),car_loc(inp_idx(curr),2),station_loc(s_num,1),station_loc(s_num,2),speed);
            t=t_wait+tic_prev+tc_prev-tic_cur;
            t_wait=t;

            if t<0
                t=0;
                t_wait=0;
            else
                T=T+t;
            end
        end
    else
        T = 0;
        penalty2=penalty2+100;
    end


    %penalty so that no two indexes are same

    count=0;
    for i=1:size
        for j=1:size
            if y(j)==i
                count=count+1;
                break
            end
        end
    end
end

count=size-count;
penalty2=count*10^5;

f2=T+penalty2