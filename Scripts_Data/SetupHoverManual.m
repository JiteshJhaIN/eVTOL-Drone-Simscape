%% Set Slider for Manual Control to Hover.

% Copyright 2025 The MathWorks, Inc.

load_system('EVTOLTiltrotor');
set_param('EVTOLTiltrotor/Controls/noQGC/Flight Mode','Value','0');
% set_param('VTOLAutopilotController/Mission', 'PortDimensions', '1');
%Set Aircraft to Manual Control Mode
TestMode=0;
%Set Visualization on.
Visualization=0;
%No guidance mission
guidanceType=0;
% disp("Enabled hover manual testbench mode.")
