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
                        winnerID = obj.arrAuctionLots(lot).getLeadingBidder;
                        lotID = obj.arrAuctionLots(lot).getID;
                        if winnerID ~= -1
                            finalPrice = obj.arrAuctionLots(lot).getCurrentBid;
                            disp(['Bidder has bidder ID: ' ...
                                , num2str(winnerID), ...
                                ', won the lot has lot ID: ', num2str(lotID)...
                                , ', with ', num2str(finalPrice), ' dollars.']);
                            budget = obj.arrBidders(winnerID).getBudget...
                                - finalPrice;
                            obj.arrBidders(winnerID).setBudget(budget);
                        else
                            disp(['Failed to sell at this auction lot, lot ID: ' ...
                                , num2str(lotID)])
                        end
                    end
                end
            end
        end
    end
end

