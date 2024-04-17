% Simulation of the GMEV1 running the SFUDS drive cycle. This simulation is for range measurement. The run continues until the battery depth of discharge > 90%
clc; close all; clear all;

exp_data = readtable('SFUDS.xls','ReadVariableNames',true);% Get the velocity values, they are in an array V.
N=length(exp_data.kph);       % Find out how many readings.
V=exp_data.kph./3.6;          % Divide all velocities by 3.6, to convert from kph to m/s

% First we set up the vehicle data.
mass = 1540 ;       % Vehicle mass + two 70 kg passengers.
area = 1.8;         % Frontal area in square metres
Cd = 0.19;          % Drag coefficient
Gratio = 37;        % Gearing ratio, = G/r
G_eff = 0.95;       % Transmission efficiency
Regen_ratio = 0.5;  % This sets the proportion of the braking that is done regeneratively using the motor.
bat_type='LA';      % Lead acid battery
NoCells=156;        % 26 of 6 cell (12 Volt) batteries.
Capacity=60;        % 60 Ah batteries. This is assumed to be the 10 hour rate capacity
k=1.12;             % Peukert coefficient, typical for good lead acid
Pac=250;            % Average power of accessories. These are the constants for the motor efficiency equation, (8.25)
kc=0.3;             % For copper losses
ki=0.01;            % For iron losses
kw=0.000005;        % For windage losses
ConL=600;           % For constant electronics losses Some constants which are calculated.
Frr=0.0048 * mass * 9.8;           % Equation (8.1)
Rin= (0.022/Capacity)*NoCells;     % Int. res, Equation (3.2)
Rin = Rin + 0.05;                  % Add a little to make allowance for connecting leads.
PeuCap= ((Capacity/10)^k)*10;      % See Equation (2.12)
count=2;
while(count) % To try different accessory loads
% Set up arrays for storing data for battery, & distance travelled. All set to zero at start. These first arrays are for storing the values at the end of each cycle.
% We shall assume that no more than 100 of any cycle is completed. (If there are, an error message will be displayed, and we can adjust this number.)
DoD_end  = zeros(1,400);
Ch_Remv_end = zeros(1,400);
Dist_end = zeros(1,400);

% We now need similar arrays for use within each cycle.
DoD=zeros(1,N);        % Depth of discharge, as in Chapter 3.
Ch_Remv=zeros(1,N);     % Charge removed from battery, Peukert corrected, as in Chapter 3.
Dist=zeros(1,N);       % Record of distance travelled in km.

Cycle=1;
% Cycle controls the outer loop, and counts the number of cycles completed. We want to keep cycling till the battery is flat. This we define as being more than
% 90% discharged. That is, DoD end > 0.9. We also use the variable XX to monitor the discharge, and to stop the loop going too far.
Discharge=0; % Initially zero.

while Discharge < 0.9
%Beginning of a cycle.************

OnedriveCycle;   % Call the script file that performs one complete cycle.
% One complete cycle done. Now update the end of cycle values.
DoD_end(Cycle) = DoD(N);
Ch_Remv_end(Cycle) = Ch_Remv(N);
Dist_end(Cycle) = Dist(N);

% Now reset the values of these "inner" arrays ready for the next cycle. They should start where they left off.
DoD(1)=DoD(N); 
Ch_Remv(1)=Ch_Remv(N);
Dist(1)=Dist(N);
Discharge = DoD_end(Cycle); % Update state of discharge

%END OF ONE CYCLE ***************
Cycle = Cycle+1;
end;

plot(Dist_end,DoD_end,'+');
grid on;hold on;
ylabel('Depth of Discharge (DoD)');
xlabel('Distance traveled/km');
title('DoD vs Distance traveled for GM EV1 on the SFUDS drive cycle','Color','r')
Pac = 800;
count = count-1;
end
