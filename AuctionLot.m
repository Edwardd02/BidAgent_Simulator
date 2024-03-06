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
            obj.leadingBidder = Bidder(-1, 0, 0, nan); 
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
        
        function description = toString(obj)
            % This function now returns a string instead of modifying the object or directly displaying.
            description = ['Lot ID: ', num2str(obj.lotID), ', Starting Bid: ', num2str(obj.startingBid), ', Current Bid: ', num2str(obj.currentBid), ', Leading Bidder ID:', num2str(obj.leadingBidder.getID)];
            disp(description);  % If you want to print it directly as well
        end
    end
end
