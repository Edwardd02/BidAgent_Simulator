classdef Bidder
    properties
        bidderID double
        budget double
        currentBid double = 0 % psychological price point
        maxBid double % 
        strategy BiddingStrategy
    end
    
    methods
        % Constructor method to create a new bidder
        function obj = Bidder(bidderID, budget, maxBid, strategy)
            obj.bidderID = bidderID;
            obj.budget = budget;
            obj.maxBid = maxBid;
            obj.strategy = strategy;
        end
        
        % Method to place a bid
        function obj = placeBid(obj, currentHighestBid)
            obj.currentBid = obj.strategy.generateBid(currentHighestBid, obj.maxBid, obj.budget);
        end
        
        % Additional methods as needed
    end
end
