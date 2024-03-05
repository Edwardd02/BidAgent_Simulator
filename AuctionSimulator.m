classdef AuctionSimulator
    properties
        auctions % Array of Auction objects
        bidders % Array of Bidder objects
        products % Array of Product objects
    end
    
    methods
        function obj = AuctionSimulator()
            % Constructor for the AuctionSimulator class.
            % This is where you might initialize your auctions, bidders, and products.
            obj.auctions = []; % Initialize empty arrays
            obj.bidders = [];
            obj.products = [];
            
            % Example initialization (you would replace this with actual logic to initialize your simulation environment)
            obj = obj.setupSimulationEnvironment();
        end
        
        function obj = setupSimulationEnvironment(obj)
            % Setup the simulation environment by initializing bidders, products, and auctions.
            
            % Example of adding products (you would customize this)
            obj.products = [Product(1, 'Art Piece', 100), Product(2, 'Vintage Car', 50000)];
            

            obj.bidders = [Bidder(1, "aggressiveStrategy", 1000), Bidder(2, "conservativeStrategy", 1000)];
            
            % Initialize auctions with products (simplified example)
            obj.auctions = [Auction(1, obj.products(1)), Auction(2, obj.products(2))];
        end
        
        function run(obj)
            % Run the simulation.
            % This method simulates the auction process, where bidders place bids on auctions.
            
            for auction = obj.auctions
                fprintf('Starting auction for %s\n', auction.product.description);
                
                for bidder = obj.bidders
                    bidAmount = bidder.placeBid(auction);
                    auction.acceptBid(bidder, bidAmount);
                    fprintf('Bidder %d placed a bid of %f on %s\n', bidder.ID, bidAmount, auction.product.description);
                end
                
                winner = auction.determineWinner();
                fprintf('Auction for %s won by Bidder %d with a bid of %f\n', auction.product.description, winner.ID, winner.bidAmount);
            end
        end
    end
end
