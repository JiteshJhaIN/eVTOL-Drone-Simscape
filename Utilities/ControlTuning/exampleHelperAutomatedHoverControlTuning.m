%exampleHelperAutomatedHoverControlTuning tune all control gains for hover
%mode.

% Copyright 2023 The MathWorks, Inc.
%Disable linearization warning
state = warning('off', 'Simulink:blocks:BmathSqrtOfNegativeNumber');
cleanup = onCleanup(@()warning(state));
options = linearizeOptions('SampleTime',0.005);
ctrloptions= pidtuneOptions;
ctrloptions.PhaseMargin=60;
ctrloptions.DesignFocus = 'balanced';

%% Enable/Disable Tuning of Loops
TuneXY = true;
TuneVxVy = true;
TunePR = true;
TunePrRr = true;
options.RateConversionMethod = 'tustin';
%% Roll rate
if TunePrRr
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Roll Rate Controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux2'],1,'openoutput');

    rollRateSys=linearize(mdl,io,5,options);
    [C,~]=pidtune(rollRateSys,'PDF',50,ctrloptions);
    controlParams.P_ROLL_RATE=C.Kp;
    controlParams.I_ROLL_RATE=C.Ki; % NO I Gain because of 1/s plant
    controlParams.D_ROLL_RATE=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_ROLL_RATE=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Sum1'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux2'],1,'openoutput');
    rollRateSys=linearize(mdl,io,5,options);
    hoverMargin.rollRateSysMargin = allmargin(rollRateSys);

end

%% Pitch rate
if TunePrRr
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Pitch Rate Controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux2'],2,'openoutput');
    pitchRateSys=linearize(mdl,io,5,options);
    [C,~]=pidtune(pitchRateSys,'PDF',50,ctrloptions);
    controlParams.P_PITCH_RATE=C.Kp;
    controlParams.I_PITCH_RATE=C.Ki; % NO I Gain because of 1/s plant
    controlParams.D_PITCH_RATE=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_PITCH_RATE=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Sum2'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux2'],2,'openoutput');
    pitchRateSys=linearize(mdl,io,5,options   );
    hoverMargin.pitchRateSysMargin = allmargin(pitchRateSys);


end

%% Yaw rate
if TunePrRr
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Yaw rate controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux2'],3,'openoutput');
    yawRateSys=linearize(mdl,io,5,options);
    [C,~]=pidtune(yawRateSys,'PDF',50,ctrloptions);
    controlParams.P_YAW_RATE=C.Kp;
    controlParams.I_YAW_RATE=C.Ki;  % NO I Gain because of 1/s plant
    controlParams.D_YAW_RATE=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_YAW_RATE=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Sum3'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux2'],3,'openoutput');
    yawRateSys=linearize(mdl,io,5,options);
    hoverMargin.yawRateSysMargin = allmargin(yawRateSys);

end

%% Design outer loop after designing inner loop.
%% Roll
if TunePR
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Roll Controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux3'],1,'openoutput');
    rollSys=linearize(mdl,io,5,options);
    [C,~]=pidtune(rollSys,'PDF',10,ctrloptions);
    controlParams.P_ROLL=C.Kp;
    controlParams.I_ROLL=C.Ki; % NO I Gain because of 1/s plant
    controlParams.D_ROLL=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_ROLL=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux3'],1,'openoutput');
    rollSys=linearize(mdl,io,5,options);
    hoverMargin.rollSysMargin = allmargin(rollSys);

end

%% Pitch
if TunePR
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Pitch Controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux3'],2,'openoutput');
    pitchSys=linearize(mdl,io,5,options);
    [C,~]=pidtune(pitchSys,'PDF',10,ctrloptions);
    controlParams.P_PITCH=C.Kp;
    controlParams.I_PITCH=C.Ki; % NO I Gain because of 1/s plant
    controlParams.D_PITCH=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_PITCH=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux'],2,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux3'],2,'openoutput');
    pitchSys=linearize(mdl,io,5,options);
    hoverMargin.pitchSysMargin = allmargin(pitchSys);

end

%% Yaw
if TunePR
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Yaw Controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux3'],3,'openoutput');
    yawSys=linearize(mdl,io,5,options);
    [C,~]=pidtune(yawSys,'PDF',10,ctrloptions);
    controlParams.P_YAW=C.Kp;
    controlParams.I_YAW=C.Ki; % NO I Gain because of 1/s plant
    controlParams.D_YAW=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_YAW=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux'],3,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Derivative Gain/Demux3'],3,'openoutput');
    yawSys=linearize(mdl,io,5,options);
    hoverMargin.yawSysMargin = allmargin(yawSys);

end

%% X Rate Controller
% NEEDS TO BE "SNAPSHOT" LINEARIZED
% SYSTEM IS VERY HIGH ORDER WITH NUMEROUS MODES
if TuneVxVy
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Forward velocity controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Forward velocity/Add'],1,'openoutput');
    try % System doesn't always linearize at t=0
        XRateSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        XRateSys=linearize(mdl,io,options,10);
    end
    [C,~]=pidtune(XRateSys,'P',5,ctrloptions);
    P_VX=C.Kp;
    I_VX = C.Ki;
    D_VX = C.Kd;

    if C.Tf<eps
        C.Tf = 0.01;
    end
    N_VX=1/C.Tf;
    controlParams.P_VX = P_VX;
    controlParams.I_VX = I_VX;
    controlParams.D_VX = D_VX;
    controlParams.N_VX = N_VX;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Sum4'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Forward velocity/Add'],1,'openoutput');
    try % System doesn't always linearize at t=0
        XRateSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        XRateSys=linearize(mdl,io,10,options);
    end
    hoverMargin.XRateSysMargin = allmargin(XRateSys);

end

%% Y Rate Controller
if TuneVxVy

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Lateral velocity controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Lateral velocity/Add'],1,'openoutput');
    try % System doesn't always linearize at t=0
        YRateSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        YRateSys=linearize(mdl,io,options,10);
    end
    [C,~]=pidtune(YRateSys,'P',5,ctrloptions);
    P_VY=C.Kp;
    I_VY = C.Ki;
    D_VY = C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    N_VY=1/C.Tf;
    % Lateral velocity controller
    controlParams.P_VY = P_VY;
    controlParams.I_VY = I_VY;
    controlParams.D_VY = D_VY;
    controlParams.N_VY = N_VY;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Sum5'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Lateral velocity/Add'],1,'openoutput');

    try % System doesn't always linearize at t=0
        YRateSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        YRateSys=linearize(mdl,io,options,10);
    end
    hoverMargin.YRateSysMargin = allmargin(YRateSys);

end

%% Z Rate Controller
if TuneVxVy
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Altitude Control/Altitude rate controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Altitude Control/Selector1'],1,'openoutput');

    try % System doesn't always linearize at t=0
        ZRateSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        ZRateSys=linearize(mdl,io,options,10);
    end
    [C,~]=pidtune(ZRateSys,'PIDF',5,ctrloptions);
    controlParams.P_VZ=-C.Kp;
    controlParams.I_VZ=-C.Ki;
    controlParams.D_VZ=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_VZ=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Altitude Control/Sum1'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Altitude Control/Selector1'],1,'openoutput');
    try % System doesn't always linearize at t=0
        ZRateSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        ZRateSys=linearize(mdl,io,options,10);
    end
    hoverMargin.ZRateSysMargin = allmargin(ZRateSys);

end

%% X Controller
% NEEDS TO BE "SNAPSHOT" LINEARIZED
% SYSTEM IS VERY HIGH ORDER WITH NUMEROUS MODES
if TuneXY
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Forward position controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Forward position'],1,'openoutput');    try % System doesn't always linearize at t=0
        XSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        XSys=linearize(mdl,io,options,10);
    end
    [C,~]=pidtune(XSys,'PDF',2,ctrloptions);
    controlParams.P_X=C.Kp;
    controlParams.I_X=C.Ki;
    controlParams.D_X=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_X=1/C.Tf;

    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Sum2'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Forward position'],1,'openoutput');
    try % System doesn't always linearize at t=0
        XSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        XSys=linearize(mdl,io,options,10);
    end
    hoverMargin.XSysMargin = allmargin(XSys);

end

%% Y Controller
if TuneXY
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Lateral position controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Lateral position'],1,'openoutput');

    try % System doesn't always linearize at t=0
        YSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        YSys=linearize(mdl,io,options,10);
    end
    [C,~]=pidtune(YSys,'PDF',2,ctrloptions);
    controlParams.P_Y=C.Kp;
    controlParams.I_Y=C.Ki;
    controlParams.D_Y=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_Y=1/C.Tf;
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Sum3'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Horizontal Position Control/XY Controller/Lateral position'],1,'openoutput');

    try % System doesn't always linearize at t=0
        YSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        YSys=linearize(mdl,io,options,10);
    end
    hoverMargin.YSysMargin = allmargin(YSys);

end

%% Z Controller
if TuneXY
    % Disable VZ Controller for linearization
    UseVZControl = false;
    io(1) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Altitude Control/Altitude controller'],1,'openinput');
    io(2) = linio([mdl '/Controls/Flight Control/Multicopter Controller/Attitude & Altitude controller/Altitude Control/Alt signal condition/Gain1'],1,'openoutput');

    try % System doesn't always linearize at t=0
        ZSys=linearize(mdl,io,5,options);
    catch % Snapshot at t=10 seconds
        ZSys=linearize(mdl,io,options,10);
    end
    UseVZControl = true;
    [C,~]=pidtune(ZSys,'PDF',1,ctrloptions);
    controlParams.P_Z=C.Kp;
    controlParams.I_Z=C.Ki;
    controlParams.D_Z=C.Kd;
    if C.Tf<eps
        C.Tf = 0.01;
    end
    controlParams.N_Z=1/C.Tf;
    hoverMargin.ZSysMargin = allmargin(ZSys);

end

%% Discard IO points
setlinio(mdl,[]);