function maxIndex = getMaxCapacityFixedWing(simData,threshold)
%   UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Copyright 2025 The MathWorks, Inc.

maxAoA = [];

for i= 1:size(simData,2)
    maxAoA =[maxAoA simData(1,i).Data(end)*57.2958];
end

maxIndex = find(maxAoA > threshold,1);


end