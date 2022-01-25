%MISO FF Neuron mapping
%ECE 6410- Intelligent control Systems - Suryakiran George
function HW2_Pbm4_2_n1_n2_1_FNN_2022
%Initialize Weights & Biases
clear;close all; clc;
n1 = 10; n2 = 5;
w1 = randn(n1,2);  b1 = randn(n1,1);
w2 = rands(n2,n1); b2 = randn(n2,1);
w3 = ones(1,n2);   b3 = randn(1);
u1 = -10:0.1:10; nCol = length(u1);
u2 = -5:0.1:5;   nRow = length(u2);
y = zeros(nRow,nCol);
%FFNN Surface
actfcn1 = 'radbas'; %logsig %tansig
actfcn2 = 'radbas'; %logsig %tansig
tic
for i = 1:nRow
    u = [u1; u2(i)*ones(size(u1))];
    y(i,:) = FNN_2n1_fcnfcn(w1,b1,w2,b2,w3,b3,u,actfcn1,actfcn2);
end
toc
%Plot
figure(1); mesh(u1,u2,y);
xlabel('u1');ylabel('u2');zlabel('y'); grid on;
[n1,n0] = size(w1); n2 = size(w2,1); n3 = size(w3,1);
title([num2str(n0),'-',num2str(n1),'-',num2str(n2),'-',num2str(n3),' FNN with '...
    actfcn1,'-',actfcn2,'-purelin']);
set(gcf,'name','             Suryakiran George Jan-24-2022')
end

function y3 = FNN_2n1_fcnfcn(w1,b1,w2,b2,w3,b3,u,actfcn1,actfcn2)
s1 = w1*u + b1*ones(1,size(u,2));
switch actfcn1
    case 'radbas',        y1 = radbas(s1);
    case 'tansig',        y1 = tansig(s1);
    case 'logsig',        y1 = logsig(s1);
end
s2 = w2*y1 + b2*ones(1,size(y1,2));
switch actfcn2
    case 'radbas',        y2 = radbas(s2);
    case 'tansig',        y2 = tansig(s2);
    case 'logsig',        y2 = logsig(s2);
end
y3 = w3*y2 + b3;
end
