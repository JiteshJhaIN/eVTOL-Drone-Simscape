%% Setup parameters for plant model

% Copyright 2025 The MathWorks, Inc.

% Load Model
mdl = 'EVTOLTiltrotor';
load_system(mdl);
% Define the aircraft modes of flight. 
Simulink.defineIntEnumType('flightState',...
{'Hover','Transition','FixedWing','BackTransition'},[0;1;2;3]);
% Set attitude to be 0.
iniRoll=0;
iniYaw=0;
initPitch=0;
% Set initial position to ground location in local coordinates (NED)
xGround=0;
yGround=0;
zGround=0;
% Set ground contact force model parameter
contact = struct('spring', 1.28931184836e5, ...
    'vd', 0.02, ...
    'slidingFriction', 0.8, ...
    'rollingFriction', 0.2,  ...
    'gLimit', 100);
% Define Bus interfaces for controller
exampleHelperDefineCtrlInterface;
% Define Plant bus interface.
exampleHelperDefineDigitalTwinInterface;
% Set VTOL Dynamics:Aerodynamics and Geometry Parameters
uavParam=exampleHelperSetVTOLDynamics;
% Flag to enable/disable visualization
Visualization = 0;
% Weight gain factor for sizing workflow
percWeightGain = 1; % default value 1
% Disable Wind
Wind=0;
% Disable Sensors
SensorType=0;
% Setup tuning flag
TuningMode = 0;
Deployment = false;
% Initialize Control and Guidance gains for Tiltrotor
exampleHelperInitializeVTOLGains;
% Initialize initial velocity
vIni = 0;
disp("Initialized VTOL model.")
% Initialize hover configuration
SetupHoverConfiguration
SetupHoverGuidanceMission
% Initialise component parameters
load('MotorPIDLoopshaped.mat');
% Initialise battery parameters
BatteryParameter;
