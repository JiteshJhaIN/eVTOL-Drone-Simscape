% Plot Bode plot for multicopter controls

% Create a cell array to hold the systems
rollContolSystems = {rollSys, rollRateSys};
pitchControlSystem = {pitchSys, pitchRateSys};
yawControlSystem = {yawRateSys,yawSys};

% Create a new figure for the Bode plot
figure;
hold on;

% Plot the Bode plot for roll system
for i = 1:length(rollContolSystems)
    margin(rollContolSystems{i});
end

% Customize the plot
title('Bode Plot of roll control Systems');
legend(["rollSys", "rollRateSys"]);
grid on;
hold off;
% Customize the plot

% Create a new figure for the Bode plot
figure;
hold on;

% Plot the Bode plot for pitch system
for i = 1:length(pitchControlSystem)
    margin(pitchControlSystem{i});
end

title('Bode Plot of pitch control Systems');
legend([ "pitchSys", "pitchRateSys"])
grid on;
hold off;

% Customize the plot
% Create a new figure for the Bode plot
figure;
hold on;

% Plot the Bode plot for yaw system
for i = 1:length(yawControlSystem)
    margin(yawControlSystem{i});
end
title('Bode Plot of yaw control Systems');
legend(["yawRateSys", "yawSys"])
grid on;
hold off;