%% Nichols plot for multicopter controls

% Create a cell array to hold the systems
rollContolSystems = {rollSys, rollRateSys};
pitchControlSystem = {pitchSys, pitchRateSys};
yawControlSystem = {yawRateSys,yawSys};

% Create a new figure for the Nichols plot
figure;
hold on;
% Plot the Nichols plot for each system
for i = 1:length(rollContolSystems)
    nichols(rollContolSystems{i});
end

% Create the legend and place it outside the plot
% Customize the plot
title('Nichols Plot of roll control Systems');
legend(["rollSys", "rollRateSys"]);
grid on;
hold off;


% Create a new figure for the Bode plot
figure;
hold on;

% Plot the Bode plot for pitch system
for i = 1:length(pitchControlSystem)
    nichols(pitchControlSystem{i});
end

title('Nichols Plot of pitch control Systems');
legend([ "pitchSys", "pitchRateSys"])
grid on;
hold off;

% Customize the plot
% Create a new figure for the Bode plot
figure;
hold on;

% Plot the Bode plot for roll system
for i = 1:length(yawControlSystem)
    nichols(yawControlSystem{i});
end
title('Nichols Plot of yaw control Systems');
legend(["yawRateSys", "yawSys"])
grid on;
hold off;