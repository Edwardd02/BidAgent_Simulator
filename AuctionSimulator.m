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
                        currentBidderBid = obj.arrBidders(i).placeBid(obj.arrAuctionLots(lot), round, obj.MaxRounds).getCurrentBid;
                   
                        if currentBidderBid > obj.arrAuctionLots(lot).getCurrentBid
                            obj.arrAuctionLots(lot).setCurrentBid(currentBidderBid);
                            obj.arrAuctionLots(lot).setLeadingBidder(obj.arrBidders(i).getID);

                        end
                    end
                    if round == obj.MaxRounds % fprintfaly Winner Info for This Particular Lot
                        winnerID = obj.arrAuctionLots(lot).getLeadingBidder;
                        lotID = obj.arrAuctionLots(lot).getID;
                        largestMaxBidID = -1;
                        largestMaxBid = -1;
                        for i = 1:length(obj.arrBidders)
                            
                            mapMaxBid = obj.arrBidders(i).getMaxBidding;
                            if largestMaxBid < mapMaxBid(lot)
                                largestMaxBid = mapMaxBid(lot);
                                largestMaxBidID = obj.arrBidders(i).getID;
                            end
                        end
                        fprintf(['Bidder has bidder ID: ' ...
                                , num2str(largestMaxBidID), ...
                                ', has the largest max bid on Lot: ', num2str(lotID)...
                                , ', the max bid is: ', num2str(largestMaxBid)...
                                ,'\n\n']);
                        if winnerID ~= -1 % When there's a winner
                            finalPrice = obj.arrAuctionLots(lot).getCurrentBid;
                            fprintf(['Bidder has bidder ID: ' ...
                                , num2str(winnerID), ...
                                ', won the lot has lot ID: ', num2str(lotID)...
                                , ', with ', num2str(finalPrice), ' dollars.\n\n']);
                            budget = obj.arrBidders(winnerID).getBudget...
                                - finalPrice;
                            obj.arrBidders(winnerID).setBudget(budget);
                        else
                            fprintf(['Failed to sell at this auction lot, lot ID: ' ...
                                , num2str(lotID)])
                        end
                    end
                end
            end
        end
    end
end

