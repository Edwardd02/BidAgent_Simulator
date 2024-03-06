classdef Bidder
    properties (Access = private)
        bidderID double
        % Individual's budget for the current auction round
        budget double
        % Individual's valuation for the 
        % auction item in the current bidding session
        currentBid double
        % Individual's maximum bidding 
        % threshold for the auction lot
        maxBid double 
        % Individual's current bidding strategy
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
        function obj = placeBid(obj, currentBid, ...
                leadingBidder)
           % The currentLeadingBidder will usually wait for next round
           if leadingBidder ~= obj.bidderID 
               obj.currentBid = obj.strategy.generateBid(...
                   currentBid, obj.maxBid, obj.budget);
           end
        end
        
        function description = toString(obj)
            % This function now returns a string instead of modifying the object or directly displaying.
            description = ['Bidder ID: ', num2str(obj.bidderID), ', Bidder Budget: ', num2str(obj.budget), ', Bidder Max Bidding: ', num2str(obj.maxBid)];
            disp(description);  % If you want to print it directly as well
        end
        
        function iD = getID(obj)
            iD = obj.bidderID;
        end

        function currentBid = getCurrentBid(obj)
            currentBid = obj.currentBid;
        end
        
        

        % Additional methods as needed
    end
end
