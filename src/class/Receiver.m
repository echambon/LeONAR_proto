classdef Receiver
    %RECEIVER GPS receiver class
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = Receiver(inputArg1,inputArg2)
            %RECEIVER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

