function tripsDone = getFlightTripBatterySizing(mileage,flightPath,capacityRange)
%% Energy consumption and range calculation for a flight plan
% EtakeOff  : Energy consumed/height for takeoff and landing
% Ehover    : Energy consumed during hover flight per m
% Ecruise   : Energy consumed during cruise flight per m
% Ehold     : Energy consumed during flight hold per sec

% Copyright 2025 The MathWorks, Inc.

tripsDone = [];

for i = 1:size(capacityRange,2)
    Ebattery  = capacityRange(i);      % Energy in battery (Wh)
    EtakeOff =  mileage.mileageTakeoff(i);    % Energy consumption rate for takeoff (E/D)
    Ehover   =  mileage.mileageHover(i);           % Energy consumption rate in hover mode (E/D)
    Ecruise  =  mileage.mileageFixed(i);      % Energy consumption rate in cruise mode (E/D)
    Ehold    =  mileage.mileageHold(i);       % Energy consumption rate in hover holde (E/s)

    EnergyCons = EtakeOff * flightPath.height + Ehover * ...
        flightPath.Distance * (1-flightPath.fixedWingRatio) + Ecruise *  ...
        flightPath.Distance * flightPath.fixedWingRatio + Ehold * flightPath.holdTime ...
        + EtakeOff * flightPath.height;
    tripsDone = [tripsDone Ebattery/EnergyCons];

end
end

