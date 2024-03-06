classdef AuctionLot
    properties (Access = private)
        lotID string
        startingBid double
        currentBid double
        minIncrement double
        leadingBidder Bidder 
    end
    
    methods
        % Constructor method to create a new product
        function obj = AuctionLot(lotID, startingBid, minIncrement)
            obj.lotID = lotID;
            obj.startingBid = startingBid;
            obj.currentBid = startingBid; 
            % Initial current bid is the starting bid
            obj.minIncrement = minIncrement;
            obj.leadingBidder = Bidder("", 0); 
            % Initialized with a dummy bidder
        end
        
        % Method to update the current bid
        function obj = updateBid(obj, newBid, bidder)
            if newBid > (obj.currentBid * (1 + obj.minIncrement))
                error('New bid must be higher than the current bid.');
            else
                obj.currentBid = newBid;
                obj.leadingBidder = bidder;
            end
        end
        
        % Method to check if there is a bid
        function hasBid = hasCurrentBid(obj)
            hasBid = ~isempty(obj.leadingBidder.Name); % Checks if there's a leading bidder
        end
        
        % Additional methods as needed for your auction logic
    end
end
