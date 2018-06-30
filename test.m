clc; clear all;close all;
f = @(x) 0.5*x.^2 + 4
y = linspace(-1,1,100);

plot(y,f(y));
%% 

%---------------------
figure(2);
plot(y,funct(y),'-',y,funct(y),'--')

figure(3);
plot(y,cool_class.funk(y))
%% 
hold on
plot(y,cool_class.funk(y),'--')