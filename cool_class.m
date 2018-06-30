classdef cool_class
    %cool_class 
    %   Contains cool stuff
    
    properties
    end
    
    methods(Static)
        function [y] = funk(x)
            z= cool_class.double_num(x);
            y = 0.5*z.^2 + 4;
            
        end
        
        function this = double_num(x)
            this = 2*x;
        end
        
        
    end
    
end

