classdef DefaultStrategy < BiddingStrategy
    properties
        incrementFactor double;
    end
    
    methods
        function obj = DefaultStrategy(incrementFactor)
            obj.incrementFactor = incrementFactor;
        end
        function bid = generateBid(obj, currentBid, maxBid, budget, minIncrement)
            proposedBid = currentBid * (1 + obj.incrementFactor);
            if proposedBid - currentBid > minIncrement
                bid = min([proposedBid, maxBid, budget]);
            else
                bid = currentBid;
            end
        end
    end
end
