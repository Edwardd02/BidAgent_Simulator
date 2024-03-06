classdef (Abstract) BiddingStrategy
    methods (Abstract)
        bid = generateBid(obj, currentBid, maxBid, budget);
    end
end
