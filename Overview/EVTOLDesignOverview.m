%% Electric Vertical Take-Off and Landing Drone Design with Simscape
% 
% This repository provides a framework for the design and 
% analysis of Vertical Take-Off and Landing (VTOL) drone systems, including 
% battery sizing, powertrain component design, and control system tuning 
% across various flight modes.
%
% Copyright 2025 The MathWorks, Inc.



%% Overview
%
% Vertical Take-Off and Landing (VTOL) aircraft represent a transformative
% advancement in aviation, offering unique capabilities such as hovering, 
% vertical flight, and efficient transitions between flight modes. As the 
% demand for urban air mobility and advanced aerial vehicles increases, the
% development of efficient and reliable VTOL systems becomes crucial as  eVTOLs
%  are more efficient than quadcopters because they utilize energy-saving 
% fixed-wing flight, whereas quadcopters depend on energy-intensive hovering. This 
% repository shows you how to tackle VTOL design challenges by focusing on 
% three core areas: *battery sizing*, *powertrain component design*, and 
% *control system tuning*.


%%
open_system('EVTOLTiltrotor')
%%


%% Design Workflows
%
% * <matlab:open('BatterySizing.mlx') Battery sizing and range estimation for EVTOL>
% * <matlab:open('MotorControlTuning.mlx') Motor control tuning>
% * <matlab:open('StabililityAnalysis.mlx') Hover mode tuning and stability>
% * <matlab:open('TuneControlFixedWingFlight.mlx') Fixed wing tuning and stability>
%

%% Documentation
% 
% * <matlab:open('ModelOverview.mlx') Model Overview>
% 

%% Models
%
% * <matlab:open_system('EVTOLTiltrotor.slx') Electric Vertical Take-Off and Landing>

%%

%% Acronyms
% * eVTOL   : Electric Vertical Take-Off and Landing
% * VTOL    : Vertical Take-Off and Landing
