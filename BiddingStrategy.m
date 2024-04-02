classdef (Abstract) BiddingStrategy
    methods (Abstract)
        bid = generateBid(obj, currentBid, maxBid, budget, roundsToLast);
    end
end
