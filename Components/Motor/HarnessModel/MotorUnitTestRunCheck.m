classdef MotorUnitTestRunCheck < matlab.unittest.TestCase
%% Class implementation of unit test
%
% These are tests to achieve the Minimum Quality Criteria (MQC).
% MQC is achieved when all runnables (models, scripts, functions) run
% without any errors.
%
% You can run this test by opening in MATLAB Editor and clicking
% Run Tests button or Run Current Test button.
% You can also run this test using test runner (the *_runtests.m script)


% Copyright 2025 The MathWorks, Inc.

methods (Test)

function MQC(test)
  mdl = "MotorTestHarness";
  load_system(mdl)
  test.addTeardown(@()close_system(mdl,0))  
  sim(mdl);
  close all
  bdclose all
end

end

end  % classdef


