classdef animatorTests < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function testSplitCode1(testCase)
            codeLine = "a = 12";
            [sweepVar, startVal, sweepRange] = splitCode(codeLine);
            testCase.verifyEqual(sweepVar,'a')
            testCase.verifyEqual(startVal,12)
            testCase.verifyEmpty(sweepRange)
        end

        function testSplitCode2(testCase)
            codeLine = "a = 12 % 10..20";
            [sweepVar, startVal, sweepRange] = splitCode(codeLine);
            testCase.verifyEqual(sweepVar,'a')
            testCase.verifyEqual(startVal,12)           
            testCase.verifyEqual(sweepRange,[10,20])
        end

        function testSplitCode3(testCase)
            codeLine = "b = -10.73 % -10.4 .. 102.1";
            [sweepVar, startVal, sweepRange] = splitCode(codeLine);
            testCase.verifyEqual(sweepVar,'b')
            testCase.verifyEqual(startVal,-10.73)
            testCase.verifyEqual(sweepRange,[-10.4,102.1])
        end

    end

end
