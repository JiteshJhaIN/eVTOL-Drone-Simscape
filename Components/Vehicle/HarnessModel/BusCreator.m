% Create Simulink Bus Objects for harness

% Copyright 2025 The MathWorks, Inc.

busInfo = Simulink.Bus.createObject(VehicleHarn);

% The top-level bus object is stored in the base workspace
oldTopLevelBusName = busInfo.busName;
topLevelBusObject = evalin('base', oldTopLevelBusName);

% Rename the top-level bus object
customTopLevelBusName = 'VehicleHarness';
assignin('base', customTopLevelBusName, topLevelBusObject);
evalin('base', ['clear ', oldTopLevelBusName]);


% Function to rename nested bus objects
function renameNestedBuses(busObject, parentName)
    for i = 1:length(busObject.Elements)
        element = busObject.Elements(i);
        if strcmp(element.DataType(1:5), 'slBus')
            subBusName = element.DataType(1:end); % Remove 'Bus: ' prefix
            subBusObject = evalin('base', subBusName);
            customSubBusName = [parentName '_', element.Name];
            assignin('base', customSubBusName, subBusObject);
            evalin('base', ['clear ', subBusName]);
            renameNestedBuses(subBusObject, customSubBusName); % Recursive call for deeper nesting
        end
    end
end

% Rename nested buses starting from the top-level bus
renameNestedBuses(topLevelBusObject, customTopLevelBusName);

% Display the new bus object names
disp(['Top-Level Bus Object: ', customTopLevelBusName]);
for i = 1:length(topLevelBusObject.Elements)
    elementName = topLevelBusObject.Elements(i).Name;
    customSubBusName = [customTopLevelBusName, '_', elementName, 'Bus'];
    if evalin('base', ['exist(''', customSubBusName, ''', ''var'')'])
        disp(['Sub Bus Object: ', customSubBusName]);
    end
end