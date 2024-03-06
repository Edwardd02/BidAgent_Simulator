classdef DefaultStrategy < BiddingStrategy
    properties
        incrementFactor double;
    end
    
    methods
        function obj = DefaultStrategy(incrementFactor)
            obj.incrementFactor = incrementFactor;
        end
        function bid = generateBid(obj, currentBid, maxBid, budget)
            proposedBid = currentBid * (1 + obj.incrementFactor);
            bid = min([proposedBid, maxBid, budget]);
        end
    end
end
