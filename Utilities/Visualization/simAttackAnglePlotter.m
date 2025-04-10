function simAttackAnglePlotter(simData,capacityRange)
%   UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure
hold on
for i= 1:size(simData,2)
    plotName = ['Batt-' num2str(capacityRange(i)) 'Wh'];
    plot(simData(1,i).time,simData(1,i).Data*57.2958,LineWidth=1,DisplayName= plotName);
end
hold off
end