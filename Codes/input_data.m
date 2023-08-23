%Input Data

function [n, m, p, car_loc, station_loc, passenger_loc, speed, capacity, car_charge, station_chargerate] = input_data;

n=5;    %no. of vehicles
m=3;    %no. of charging stations
p=5;    %No. of passengers

car_loc=[0 0;
    20 28;
    26 45;
    55 71;
    78 34];

station_loc=[77 45;
    42 59;
    29 25];

passenger_loc=[10 8;
    39 55;
    51 43;
    62 59;
    83 72];

speed=30;

capacity=20;

car_charge=[6 8 4 12 7];

station_chargerate=[6 8 10];