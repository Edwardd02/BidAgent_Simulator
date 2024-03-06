classdef DefaultStrategy < BiddingStrategy
    properties
        IncrementFactor double = 0.05; % Increase bid by 5%
    end
    
    methods
        function bid = generateBid(~, currentBid, maxBid, budget)
            proposedBid = currentBid * (1 + obj.IncrementFactor);
            bid = min([proposedBid, maxBid, budget]);
        end
    end
end
