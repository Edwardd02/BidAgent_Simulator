classdef (Abstract) BiddingStrategy
    methods (Abstract)
        bid = generateBid(obj, currentBid, maxBid, budget, minIncrement, roundsToLast);
    end
end
