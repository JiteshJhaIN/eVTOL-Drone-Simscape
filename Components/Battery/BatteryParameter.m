%% Parameters for simple and table-based Battery
% Battery parameters

% Copyright 2025 The MathWorks, Inc.
 
 
% Simple battery parameters
battery.Volt=22.5;   % (V) battery nominal voltage
battery.R = 0.001;   % (Ohm) battery internal resistance


% Table based battery parameter
battery.AH=10;                     % [Ah] Cell capacity 
battery.initialPackSOC=0.75;	     % Pack intial SOC (-)
battery.ambient=25+273.15;          %[K] Ambient temperature in K
battery.GravDensity = 180;     % Gravimetric density of battery (Wh/kg)


%% Module Electrical
battery.Ns=6;    % Number of series connected strings
battery.Np=1;      % Number of parallel cells per string

