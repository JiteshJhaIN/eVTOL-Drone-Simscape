% Setup Hover configuration.

% Copyright 2025 The MathWorks, Inc.

FSState=flightState.Hover;
%Get initial velocity and tilt based on flight mode.
[vIni,tiltIni]=exampleHelperGetInitialConfiguration(FSState);
%Set Time for Simulation
myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');
simTimeParam = getEntry(dDataSectObj,'simTime');
setValue(simTimeParam,20);
disp("Enabled hover configuration.")
%Set Visualization on.
Visualization=1;
%Set Test Bench to execute complex guidance mission
TestMode=1;
%Set guidance type to execute hover mission.
guidanceType=2;
%Sensors are disabled
SensorType=0;
%% Setup Hover maintain position
HoverMission = struct('mode',1,'position',[0,0,0]','params',[0;0;0;0]);
HoverMission(1)=struct('mode',1,'position',[0,0,0]','params',[0;0;0;0]);
HoverMission(2)=struct('mode',2,'position',[0,0,-20]','params',[0;0;0;0]);

%Set waypoint guidance parameters
R_WAYPOINTTRANSITION=1;
R_LOOKAHEAD=5;
