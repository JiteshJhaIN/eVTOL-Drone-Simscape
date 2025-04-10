%exampleHelperAutomatedMotorControlTuning tune all control gains for hover
%mode.
% Copyright 2023 The MathWorks, Inc.
%Disable linearization warning
mdl = 'EVTOLTiltrotor'
state = warning('off', 'Simulink:blocks:BmathSqrtOfNegativeNumber');
cleanup = onCleanup(@()warning(state));
options = linearizeOptions('SampleTime',0.005);
ctrloptions= pidtuneOptions;
ctrloptions.PhaseMargin=60;
ctrloptions.DesignFocus = 'balanced';

options.RateConversionMethod = 'tustin'

io(1) = linio([mdl '/Powertrain/Propulsion System 1/Propeller Motor/Speed Controller/PID Controller2'],1,'openinput');
io(2) = linio([mdl '/Powertrain/Propulsion System 1/Propeller Motor/Speed Controller/20Hz Lowpass Filter'],1,'openoutput');

motorSys=linearize(mdl,io,2,options);
% margin(motorSys)
% nichols(motorSys)

[C,~]=pidtune(motorSys,'PIDF',100,ctrloptions)
Kpp=C.Kp;
Kii=C.Ki; 
Kdd=C.Kd;
if C.Tf<eps
    C.Tf = 0.01;
end
N=1/C.Tf;

% 
% io(1) = linio([mdl '/Powertrain1/Propulsion System 1/Propeller Motor/Speed Controller/Gain1'],1,'openinput');
% io(2) = linio([mdl '/Powertrain1/Propulsion System 1/Propeller Motor/Speed Controller/20Hz Lowpass Filter'],1,'openoutput');
% 
% motorSys=linearize(mdl,io,options);
% margin(motorSys)