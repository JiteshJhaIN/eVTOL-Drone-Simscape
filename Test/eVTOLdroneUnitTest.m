classdef eVTOLdroneUnitTest < matlab.unittest.TestCase
%% Class implementation of unit test

% Copyright 2025 The MathWorks, Inc.

methods (Test)

function MQC_Harness(testCase)
  mdl = "EVTOLTiltrotor";
  % Load the Model
  load_system(mdl)
  testCase.addTeardown(@()close_system(mdl, 0));
  % Simulate the harness model
  sim(mdl);
end

end

end  % classdef