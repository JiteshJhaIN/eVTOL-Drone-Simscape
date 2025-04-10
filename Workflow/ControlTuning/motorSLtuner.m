%% Motor tuning script 
% Tune the motor PID controller by systune

% Copyright 2025 The MathWorks, Inc.


%%Disable linearization warning
mdl = 'EVTOLTiltrotor';
state = warning('off', 'Simulink:blocks:BmathSqrtOfNegativeNumber');
cleanup = onCleanup(@()warning(state));
options = linearizeOptions('SampleTime',0.005);
ctrloptions= pidtuneOptions;
ctrloptions.PhaseMargin=70;
ctrloptions.DesignFocus = 'balanced';

options.RateConversionMethod = 'tustin';
SetupHoverManual;

%% Reset multicopter commands to 0 for linearization.
set_param([mdl '/Manual Control Dashboard/Slider1'],'Value','5')
set_param([mdl '/Manual Control Dashboard/Slider2'],'Value','100');
set_param([mdl '/Manual Control Dashboard/Slider3'],'Value','0');



%% Define blocks to tune
PID1 = 'EVTOLTiltrotor/Powertrain/Propulsion System 1/Propeller Motor/Speed Controller/PID Controller2';
tunedBlocks = {PID1};

%% Define analysis points based on design goals for the loops to tune
PID1OpLoopLocation = [PID1,'/1' ];
PID1Input  = 'EVTOLTiltrotor/Controls/Flight Control/Scheduler/MulticopterScheduler/Actuator To Voltage/Saturation/1';
PID1Output = 'EVTOLTiltrotor/Powertrain/Propulsion System 1/Propeller Motor/rpm2rps/1';
PlantOutput = 'EVTOLTiltrotor/Powertrain/Propulsion System 1/Propeller Motor/rpm2rps/1';
analysisPoints = {PID1OpLoopLocation,PID1Input,PID1Output};


options=slTunerOptions('AreParamsTunable',false);
attitudeTuner=slTuner(mdl,tunedBlocks,analysisPoints,options);
attitudeTuner.Ts=0.005;
attitudeTuner.OperatingPoints=5;
attitudeTuner.Options.RateConversionMethod  = 'tustin';

%% Loop shaping
pid1LoopShape = TuningGoal.LoopShape({PID1OpLoopLocation}, tuningTarget.wc);
pid1LoopShape.Name = 'Pid1 Loop Shape';
viewGoal(pid1LoopShape);




%% PID step tracking
PID1StepTracking = TuningGoal.StepTracking({PID1Input},{PID1Output}, tuningTarget.tau, 1);
PID1StepTracking.Openings = [{PID1Input}];%; {PID2Input};{PID3Input};{PID4Input}];
PID1StepTracking.Name = 'motor1 Step Tracking';

% viewGoal(PID1StepTracking);
%% PID margin
% Define gain and phase margin requirements
% Example: Gain margin of 20 dB and phase margin of 60 degrees
marginRequirement = TuningGoal.Margins( PlantOutput, tuningTarget.gain, tuningTarget.phase);

%% Options
options = systuneOptions();
options.Display = 'final';

%% Tune
attitudeTuner_Tuned= systune(attitudeTuner,[pid1LoopShape;PID1StepTracking; ...
    marginRequirement],options);

% % Get the tuned transfer function
%  T_tuned = getIOTransfer(attitudeTuner, PID1Input, PlantOutput);
% % Check the gain and phase margins
% figure;
% margin(T_tuned);
% title('Gain and Phase Margins of Tuned System');

exampleHelperViewTuningGoal([pid1LoopShape,PID1StepTracking,...
    marginRequirement],attitudeTuner_Tuned);

motorPidLoopshaping=exampleHelperWriteBlockValue_Attitude(attitudeTuner_Tuned);
%% 

motorPID.Kpp = motorPidLoopshaping.Kp;
motorPID.Kii = motorPidLoopshaping.Ki;
motorPID.Kdd = motorPidLoopshaping.Kd;
motorPID.N = 1/motorPidLoopshaping.Tf;

