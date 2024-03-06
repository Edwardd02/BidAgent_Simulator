function Main

% initialization
numOfBidders = 30;
numOfAuctionLot = 5;
minIncrementFactor = 0.05;
maxRounds = 10;
arrAuctionLots = repmat(AuctionLot(0, 0, 0), numOfAuctionLot, 1);

% initialization for Bidders
arrBidders = Bidder.empty(numOfBidders, 0); % Correct approach for preallocating empty array of objects
for i = 1:numOfBidders
    initialMaxBids = containers.Map('KeyType', 'double', 'ValueType', 'double');
    for j = 1:numOfAuctionLot
        lotID = j;
        maxBid = rand(1) * 10000 + 1000; % Random max bid for this lot
        initialMaxBids(lotID) = maxBid;
    end
    budget = rand(1) * 100000 + 10000; % Random budget for each bidder
    incrementFactor = rand(1) * 0.05;
    strategyInstanceDefault = DefaultStrategy(incrementFactor);
    arrBidders(i) = Bidder(i, budget, initialMaxBids, strategyInstanceDefault); % bidderID, budget, maxBids for lots, strategy
end

% initializing AuctionLots
for i = 1:numOfAuctionLot
    startingBid = rand(1) * 1000 + 100;
    minIncrement = startingBid * minIncrementFactor;
    arrAuctionLots(i) = AuctionLot(i, startingBid, minIncrement); % lotID, startingBid, minIncrement
end


Auction1 = AuctionSimulator(arrAuctionLots, arrBidders, maxRounds); % arrAuctionLots, arrBidders, maxRounds
Auction1.run;
%Tests
%Test on Initialization
for i = 1:numOfBidders
    arrBidders(i).toString();
end
for i = 1:numOfAuctionLot
    arrAuctionLots(i).toString();
end

