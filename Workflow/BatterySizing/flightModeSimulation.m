function [range, mileage, angleOfAttack] = flightModeSimulation(options)
% This function sets up simulation run for different flight modes. Based on
% the capacity of the battery, weight of the drone is calculated to run the
% model and log the simulation data for range and mileage analysis
%
% Copyright 2025 The MathWorks, Inc.

arguments
    options.CapacityRange (1,:) {mustBeVector, mustBePositive} = [300];
    options.BaseMass (1,1) { mustBeNumeric,mustBePositive} = 6.023;
    options.GravDensity (1,1) { mustBeNumeric,mustBePositive} = 180;
    options.RangeType string {mustBeMember(options.RangeType, ["Distance", "Time"])} = "Distance";

end
% initialize output variables
mileage= [];
range = [];
angleOfAttack =[];
% Load model if not already loaded
if ~bdIsLoaded('EVTOLTiltrotor')
    load_system('EVTOLTiltrotor');
    closeOrigModel = onCleanup(@()bdclose('EVTOLTiltrotor'));
end

simIn = Simulink.SimulationInput('EVTOLTiltrotor');

for i = 1:size(options.CapacityRange,2)
    % Battery weight for given capacity
    batteryWeight = options.CapacityRange(i)/options.GravDensity;
    % Increase in total mass of the aircraft due to battery
    percWeightGain =  (options.BaseMass + batteryWeight)/options.BaseMass;
    simIn = setVariable(simIn,'percWeightGain',percWeightGain);
    % Simulate model
    simData = sim(simIn);
    % Angle of attack value
    angleOfAttack = [angleOfAttack simData.Alpha];
    if strcmp(options.RangeType,"Time")
        % Calculate the available flight time using electric power consumtion
        range = [range (options.CapacityRange(i)*3600)/mean(simData.elecPower.Data)];
        mileage = [mileage mean(simData.elecPower.Data)/3600];
    else
        % Calculate the range by dividing the battery capacity by the energy consumption rate
        range = [range options.CapacityRange(i)/simData.EnergyMileage.Data(end)];
        mileage = [mileage simData.EnergyMileage.Data(end)];

    end
end

end