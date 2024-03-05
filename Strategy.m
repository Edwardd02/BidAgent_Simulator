classdef (Abstract) Strategy
    methods (Abstract)
        bid = generateBid(strategy, currentBid, maxBid, budget)
    end
end


