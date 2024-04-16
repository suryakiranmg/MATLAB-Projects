clc; close all; clear all;

disp('1 - FUDS, 2 - SFUDS, 3 - Federal Test Procedure');
disp('4 - Highway Fuel Economy Driving, 5 - Supplemental FTP');
CaseNo = input('Choose the Drive cycle data:');

switch CaseNo
    case 1
        exp_data = readtable('FUDS.xls','ReadVariableNames',true);
        xdata = exp_data.Time;
        ydata = exp_data.mph;
        hold on;
        scatter(xdata,ydata,30,"blue","filled"); line(xdata,ydata);
        grid on; xlabel('Time,secs');ylabel('Vehicle Speed,mph');
        title('Federal Urban Driving Schedule');
    case 2
        exp_data = readtable('SFUDS.xls','ReadVariableNames',true);
        xdata = exp_data.Time;
        ydata = exp_data.mph;
        hold on;
        scatter(xdata,ydata,25,"green","filled"); line(xdata,ydata);
        grid on; xlabel('Time,secs');ylabel('Vehicle Speed,mph');
        title('Simplified Federal Urban Driving Schedule');        
    case 3
        exp_data = readtable('ftpcol.xls','ReadVariableNames',true);
        xdata = exp_data.Time;
        ydata = exp_data.mph;
        hold on;
        scatter(xdata,ydata,25,"blue","filled"); line(xdata,ydata);
        grid on; xlabel('Time,secs');ylabel('Vehicle Speed,mph');
        title('EPA75: Federal Test Procedure (Urban Dyno Drive Schedule)');              
    case 4
        exp_data = readtable('hwycol.xls','ReadVariableNames',true);
        xdata = exp_data.Time;
        ydata = exp_data.mph;
        hold on;
        scatter(xdata,ydata,25,"yellow","filled"); line(xdata,ydata);
        grid on; xlabel('Time,secs');ylabel('Vehicle Speed,mph');
        title('Highway Fuel Economy Driving Schedule (Highway driving under 60mph))'); 
    case 5
        exp_data = readtable('us06col.xls','ReadVariableNames',true);
        xdata = exp_data.Time;
        ydata = exp_data.mph;
        hold on;
        scatter(xdata,ydata,25,"cyan","filled"); line(xdata,ydata);
        grid on; xlabel('Time,secs');ylabel('Vehicle Speed,mph');
        title('US06: Supplemental Federal Test Procedure (High Accln,aggressive driving)');      
end
Max_Speed_mph = max(exp_data.mph)
Avg_Speed_mph = mean(exp_data.mph)
Diff_Speed = diff(exp_data.mph);
MaxAcceleration_mph_per_sec = max(Diff_Speed)
MaxDeceleration_mph_per_sec = min(Diff_Speed)
Time_mins = max(exp_data.Time)/60
Distance_Traveled_miles = sum(exp_data.mph)/(60*60)



