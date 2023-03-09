% loading data

clear all;
close all;

load 201503.mat;


% loading grids of cartesian (in km) and geo (in lon-lat) grids
load TOROS_grids_f.mat;

% check time
%% use 
datestr(time0_monthly(1))  % check time for 1st data...

datestr(time0_monthly(744))  % check time for 100th data...


% making basic figure

figure(1);
quiver(x0, y0, u0_monthly(:,:,1), v0_monthly(:,:,1))