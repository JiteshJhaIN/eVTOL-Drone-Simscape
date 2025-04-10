function controlParams = exampleHelperWriteBlockValue_FwAttitude(hTuner,controlParams)
%exampleHelperWriteBlockValue Write tuned control gains to control param structure

% Copyright 2023 The MathWorks, Inc.


pitchAngleController = getBlockValue(hTuner,'Pitch Angle Controller');
controlParams.P_FW_PITCH = pitchAngleController.Kp;
controlParams.I_FW_PITCH = pitchAngleController.Ki;
controlParams.D_FW_PITCH = pitchAngleController.Kd;
controlParams.N_FW_PITCH = 1/pitchAngleController.Tf;

rollRateController = getBlockValue(hTuner,'Roll Rate Controller');
controlParams.P_FW_ROLLRATE = rollRateController.Kp;
controlParams.I_FW_ROLLRATE = rollRateController.Ki;

pitchRateController = getBlockValue(hTuner,'Pitch Rate Controller');
controlParams.P_FW_PITCHRATE = pitchRateController.Kp;

end