classdef AuctionSimulator
    properties (Access = private)
        arrAuctionLots % Array of Product objects
        arrBidders % Array of Bidder objects
        MaxRounds % Maximum number of bidding rounds
    end
    
    methods
        % Constructor method to initialize the simulation
        function obj = AuctionSimulator(arrAuctionLots, arrBidders, maxRounds)
            obj.arrAuctionLots = arrAuctionLots;
            obj.arrBidders = arrBidders;
            obj.MaxRounds = maxRounds;
        end
        
        % Method to run the simulation
        function run(obj) 
            for lot = 1:length(obj.arrAuctionLots) % loop through Lots
                for round = 1:obj.MaxRounds % loop through rounds
                    for i = 1:length(obj.arrBidders) % loop through bidders
                        currentBidderBid = obj.arrBidders(i).placeBid(obj.arrAuctionLots(lot)).getCurrentBid;
                        if currentBidderBid > obj.arrAuctionLots(lot).getCurrentBid
                            obj.arrAuctionLots(lot).setCurrentBid(currentBidderBid);
                            obj.arrAuctionLots(lot).setLeadingBidder(obj.arrBidders(i).getID);

                        end
                    end
                    if round == obj.MaxRounds
                        disp(["Bidder has bidder ID: ", ...
                            num2str(obj.arrAuctionLots(lot).getLeadingBidder),...
                            "won lot has lot ID", num2str(obj.arrAuctionLots(lot).getID)]);
                        budget = obj.arrBidders(obj.arrAuctionLots(lot).getLeadingBidder).getBudget...
                            - obj.arrAuctionLots(lot).getCurrentBid;
                        obj.arrBidders(obj.arrAuctionLots(lot).getLeadingBidder).setBudget(budget);
                    end
                end
            end
        end
    end
end

