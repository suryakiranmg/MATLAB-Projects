% GMEV1 Model - Full Power (WOT) Acceeration Curve
% Performance Chara : Acceleration profile
clc; clear all; close all;

t=linspace(0,20,201);  % 0 to 20 seconds, in 0.1 second steps
v=zeros(1,201);        % 201 reading of velocity
deltaT=0.1;            % 0.1 second time step

data = xlsread('IN_Data.xlsx');
a1 = data(1,1); a2 = data(2,1); b1 = data(3,1); b2 = data(4,1); b3 = data(5,1);

% In this case there are three phases to the WOT acceleration curve
% Phase 1: Constant torque region (T=Tmax)
% Phase 2: Constant power region  (T = P/((G/r)*v))
% Phase 3: Max speed limit reached

for n=1:200
   if v(n)< 19.8  %44mph=71kph : Constant Torque region
      v(n+1) = v(n) + deltaT*(a1 + (a2*(v(n)^2)));
   elseif v(n) > 35.8  %80mph=129kph : Max Speed cut-off
      v(n+1) = v(n);
   else  %between (44-80)mph : Constant Power region
      v(n+1) = v(n) + deltaT * ((b1/v(n)) - b2 - (b3*(v(n)^2)));
   end;   
end;

v = v.*2.23694; %Convert velocity from m/s to mph
plot(t,v,'b-','Marker', '.','markersize',6);
grid on;
xlabel('Time / seconds');
ylabel('velocity / mph');
title('Full power WOT 0-60 acceleration of GM EV1 electric car');
axis([0 20 0 90]);

