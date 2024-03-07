classdef AuctionLot < handle
    properties (Access = private)
        lotID double
        startingBid double
        currentBid double
        minIncrement double %TODO:
        leadingBidder double 
    end
    
    methods
        % Constructor method to create a new product
        function obj = AuctionLot(lotID, startingBid, minIncrement)
            obj.lotID = lotID;
            obj.startingBid = startingBid;
            obj.currentBid = startingBid; 
            % Initial current bid is the starting bid
            obj.minIncrement = minIncrement;
            obj.leadingBidder = -1; 
            % Initialized with a dummy bidder
        end
       
        
        function description = toString(obj)
            % This function now returns a string instead of modifying the object or directly displaying.
            description = ['Lot ID: ', num2str(obj.lotID), ...
                ', Starting Bid: ', num2str(obj.startingBid), ...
                ', Current Bid: ', num2str(obj.currentBid), ...
                ', Leading Bidder ID: ', num2str(obj.leadingBidder)];
            disp(description);  % If you want to print it directly as well
        end
        function ID = getID(obj)
            ID = obj.lotID;
        end
        function currentBid = getCurrentBid(obj)
            currentBid = obj.currentBid;
        end

        function leadingBidder = getLeadingBidder(obj)
            leadingBidder = obj.leadingBidder;
        end
        
        function minIncrement = getMinIncrement(obj)
            minIncrement = obj.minIncrement;
        end
        function obj = setCurrentBid(obj, currentBid)
            obj.currentBid = currentBid;
        end

        function obj = setLeadingBidder(obj, leadingBidder)
            obj.leadingBidder = leadingBidder;
        end
        

    end
end
