classdef Bidder
    %BIDDERS: Represents participants in the auction. 
    %   Detailed explanation goes here
    
    properties (Access=private)
        bidderId
        strategy
        expectedValue 
        liabilities 
    end
    
    methods
        function obj = Bidder(bidderId, strategy, liabilities)
            obj.bidderId = bidderId;
            obj.strategy = strategy;
            obj.liabilities = liabilities;
        end
        
        function strategy = updateStrategy(strategy)
            obj.stragtegy = strategy;
        end
    end
end

