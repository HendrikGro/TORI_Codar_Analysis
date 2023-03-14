% loading data

clear all;
close all;

load 201503.mat;


% loading grids of cartesian (in km) and geo (in lon-lat) grids
load TOROS_grids_f.mat;

% check time
%% use 
%datestr(time0_monthly(1))  % check time for 1st data...

%datestr(time0_monthly(100))  % check time for 100th data...


% making basic figure

%figure(1);
%quiver(x0, y0, u0_monthly(:,:,1), v0_monthly(:,:,1))

nan_index = ~isnan(u0_monthly(10,10,:));

u_data = u0_monthly(10,10,:);
u_data = squeeze(u_data(nan_index));
%t = squeeze(time0_monthly(nan_index));
t = linspace(0,1,744);
t = transpose(t(nan_index));

f = transpose((-744/2 + (1:744))/744);
Y = nufft(u_data,t,f);

%
% n = length(t);
%f = (0:n-1)/n;
loglog(f,abs(Y))