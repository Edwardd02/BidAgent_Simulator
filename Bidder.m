classdef Bidder
    properties (Access = private)
        bidderID double
        budget double
        currentBid double
        % the individual's psychological valuation for the auction item in 
        % the current bidding session
        maxBid double 
        % the individual's maximum psychological bidding threshold for the 
        % auction lot
        strategy
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
            obj.currentBid = obj.strategy.generateBid(currentHighestBid,...
                obj.maxBid, obj.budget);
        end
        
        function description = toString(obj)
            % This function now returns a string instead of modifying the object or directly displaying.
            description = ['Bidder ID: ', num2str(obj.bidderID), ', Bidder Budget: ', num2str(obj.budget), ', Bidder Max Bidding: ', num2str(obj.maxBid)];
            disp(description);  % If you want to print it directly as well
        end
        
        function iD = getID(obj)
            iD = obj.bidderID;
        end
        % Additional methods as needed
    end
end
