classdef Bidder < handle
    properties (Access = private)
        bidderID double
        % Individual's budget for the current auction round
        budget double
        % Individual's valuation for the 
        % auction item in the current bidding session
        currentBid double
        % Individual's maximum bidding 
        % threshold for the auction lot
        % dictionary variable type
        maxBid containers.Map
        % Individual's current bidding strategy
        strategy
    end
    
    methods
        % Constructor method to create a new bidder
        function obj = Bidder(bidderID, budget, initialMaxBids, strategy)
            obj.bidderID = bidderID;
            obj.budget = budget;
            if isa(initialMaxBids, 'containers.Map')
                obj.maxBid = initialMaxBids;
            else
                error('initialMaxBids must be a containers.Map object');
            end
            obj.strategy = strategy;
        end
        
        % Method to place a bid
        function obj = placeBid(obj, AuctionLot)
           % The currentLeadingBidder will usually wait for next round
           if AuctionLot.getLeadingBidder ~= obj.bidderID
               maxBidToLot = obj.maxBid(AuctionLot.getID);
               obj.currentBid = obj.strategy.generateBid(...
                   AuctionLot.getCurrentBid, maxBidToLot, obj.budget, AuctionLot.getMinIncrement);
               
           end
        end
        
        function iD = getID(obj)
            iD = obj.bidderID;
        end

        function currentBid = getCurrentBid(obj)
            currentBid = obj.currentBid;
        end
        
        function budget = getBudget(obj)
            budget = obj.budget;
        end

        function obj = setBudget(obj, budget)
            obj.budget = budget;
        end

        function description = toString(obj)
            % This function now returns a string instead of modifying the object or directly displaying.
            description = ['Bidder ID: ', num2str(obj.bidderID), ', Bidder Budget: ', num2str(obj.budget),...
                obj.maxBidToString];
            disp(description);  % If you want to print it directly as well
        end
        function maxBidStr = maxBidToString(obj)        
            keySet = keys(obj.maxBid);
            valueSet = values(obj.maxBid);
            maxBidStr = ' Max Bids: ';
            % Loop through all key-value pairs and append them to the string
            for i = 1:length(keySet)
                maxBidStr = [maxBidStr, 'Lot ', num2str(keySet{i}), ': $', num2str(valueSet{i}), '; '];
            end
        end

        % Additional methods as needed
    end
end
