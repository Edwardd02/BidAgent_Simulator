classdef SimpleIncrementStrategy < BiddingStrategy
    properties
        incrementFactor double;
    end
    
    methods
        function obj = SimpleIncrementStrategy(incrementFactor)
            obj.incrementFactor = incrementFactor;
        end
        function bid = generateBid(obj, currentBid, maxBid, budget, minIncrement, roundsToLast) % Unused arguments: roundToLast
            proposedBid = currentBid * (1 + obj.incrementFactor);
            if proposedBid - currentBid > minIncrement
                bid = min([proposedBid, maxBid, budget]);
            else
                bid = currentBid;
            end
        end
    end
end
