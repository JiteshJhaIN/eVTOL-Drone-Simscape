% Setup Fixed Wing configuration.

% Copyright 2025 The MathWorks, Inc.

FSState=flightState.FixedWing;

% Set Test Bench to execute complex guidance mission
TestMode=1;

% Set guidance type to execute fixed wing mission.
guidanceType=1;

% Enable Visualization
Visualization = 0;

%Disable Sensors
SensorType=0;
% Setup Fixed Wing Mission
clear FixedWingMission;
FixedWingMission(1)=struct('mode',2,'position',[10,0,-0]','params',[0;0;0;0]);
FixedWingMission(2)=struct('mode',2,'position',[200,0,-20]','params',[0;0;0;0]);
% FixedWingMission(3)=struct('mode',2,'position',[500,-200,-20]','params',[0;0;0;0]);
FixedWingMission(3)=struct('mode',3,'position',[600,-0,-20]','params',[50;-1;10;0]);

myDictionaryObj = Simulink.data.dictionary.open('VTOLDynamicsData.sldd');
dDataSectObj = getSection(myDictionaryObj,'Design Data');
controlParam = getEntry(dDataSectObj,'control');
cont = getValue(controlParam);
cont.cruiseSpeed = 20;                                                                                                      
setValue(controlParam, cont);
