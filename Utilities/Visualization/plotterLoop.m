function plotterLoop(simData,data,time)
%PLOTTERLOOP Summary of this function goes here
%   Detailed explanation goes here
figure
hold on
timeData = ['simData(1,i).' time];
valueData = ['simData(1,i).' data];

for i= 1:size(simData,2)
    plot(eval(timeData),eval(valueData),LineWidth=1)
end
hold off

end

