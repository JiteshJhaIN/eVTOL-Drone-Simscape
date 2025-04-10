function controlParams = exampleHelperWriteBlockValue_Attitude(hTuner)
%exampleHelperWriteBlockValue Write tuned control gains to control param structure

% Copyright 2023 The MathWorks, Inc.

controlParams = getBlockValue(hTuner,'EVTOLTiltrotor/Powertrain/Propulsion System 1/Propeller Motor/Speed Controller/PID Controller2');
Kpp = controlParams.Kp;
Kii = controlParams.Ki;
Kdd = controlParams.Kd;

end