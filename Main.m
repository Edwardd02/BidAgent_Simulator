function Main
% Main function to initialize and run the auction simulation

    % Initialization of simulation parameters
    numOfBidders = 30;
    numOfAuctionLot = 1; % Assuming one auction lot for simplicity, but the structure allows for more
    minIncrementFactor = 0.03;
    maxRounds = 100;

    % Initializing AuctionLots
    arrAuctionLots = initializeAuctionLots(numOfAuctionLot, minIncrementFactor);

    % Initializing Bidders
    arrBidders = initializeBidders(numOfBidders, numOfAuctionLot);

    % Creating and running the auction simulation
    Auction1 = AuctionSimulator(arrAuctionLots, arrBidders, maxRounds);
    Auction1.run;
end

function arrAuctionLots = initializeAuctionLots(numOfAuctionLot, minIncrementFactor)
    % Preallocates and initializes auction lots with starting bid and minimum increment
    arrAuctionLots = AuctionLot.empty(numOfAuctionLot, 0);
    for i = 1:numOfAuctionLot
        startingBid = rand(1) * 1000 + 100; % Generate random starting bid
        minIncrement = startingBid * minIncrementFactor; % Calculate minimum increment
        arrAuctionLots(i) = AuctionLot(i, startingBid, minIncrement); % Initialize AuctionLot object
    end
end

function arrBidders = initializeBidders(numOfBidders, numOfAuctionLot)
    % Preallocates and initializes bidders with their budget, max bids, and strategy
    arrBidders = Bidder.empty(numOfBidders, 0); % Preallocating empty array of objects
    for i = 1:numOfBidders
        initialMaxBids = initializeMaxBids(numOfAuctionLot);
        budget = rand(1) * 100000 + 10000; % Generate random budget
        incrementFactor = rand(1) * 0.05; % Generate random increment factor for strategy
        strategyInstanceDefault = SimpleIncrementStrategy(incrementFactor); % Initialize bidding strategy
        arrBidders(i) = Bidder(i, budget, initialMaxBids, strategyInstanceDefault); % Initialize Bidder object
    end
end

function initialMaxBids = initializeMaxBids(numOfAuctionLot)
    % Initializes the max bids for each auction lot for a bidder
    initialMaxBids = containers.Map('KeyType', 'double', 'ValueType', 'double');
    for j = 1:numOfAuctionLot
        lotID = j;
        maxBid = rand(1) * 10000 + 1000; % Generate random max bid for this lot
        initialMaxBids(lotID) = maxBid;
    end
end

