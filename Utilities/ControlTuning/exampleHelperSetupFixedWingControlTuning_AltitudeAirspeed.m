%exampleHelperSetupFixedWingControlTuning_Attitude Setup fixed wing linearization of attitude loops
%for control tuning.

% Copyright 2023 The MathWorks, Inc.

%Set Slider for Manual Control to Fixed Wing.
mdl = 'EVTOLTiltrotor'

set_param([mdl '/Manual Control Dashboard/FlightModeSlider'],'Value','2');

TestMode = 0;
TuningMode = 1;
guidanceType = 0;
controllerBlock = [mdl,'/Controls/Flight Control/Fixed Wing Controller/Fixed Wing Controller Module/Fixed Wing Controller Tuning'];

% Define blocks to tune
tunedBlocks = {[controllerBlock,'/Airspeed-Altitude Controller/Altitude Controller/PID Controller']; ...
               [controllerBlock,'/Airspeed-Altitude Controller/Pitch SP Controller/PID Controller']; ...
               [controllerBlock,'/Airspeed-Altitude Controller/Airspeed Controller']};

% Define analysis points based on design goals for the loops to tune
altitudeOpenLoopLocation = [controllerBlock,'/Pitch SP Switch/1'];
altitudeInput = [controllerBlock,'/In Bus Element2/1'];
altitudeOutput = [controllerBlock,'/Gain/1'];
airspeedOpenLoopLocation = [controllerBlock,'/Actuator dT Switch/1'];
airspeedInput = [controllerBlock,'/In Bus Element1/1'];
airspeedOutput = [controllerBlock,'/In Bus Element29/1'];

analysisPoints = {altitudeOpenLoopLocation,altitudeInput,altitudeOutput,airspeedOpenLoopLocation,airspeedInput,airspeedOutput}';