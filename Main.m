function Main

% initialization
numOfBidders = 30;
numOfAuctionLot = 5;
incrementFactor = .05;
maxRounds = 30;
strategyInstanceDefault = DefaultStrategy(incrementFactor);

arrBidders = repmat(Bidder(0, 0, 0, strategyInstanceDefault), numOfBidders, 1);
arrAuctionLots = repmat(AuctionLot(0, 0, 0), numOfAuctionLot, 1);
% initializing Bidders
for i = 1:numOfBidders
    budget = rand(1) * 100000 + 10000;
    maxBid = rand(1) * 10000 + 1000;
    arrBidders(i) = Bidder(i, budget, maxBid, strategyInstanceDefault); % bidderID, budget, maxBid, strategy
end
% initializing AuctionLots
for i = 1:numOfAuctionLot
    startingBid = rand(1) * 1000 + 100;
    minIncrement = startingBid * incrementFactor;
    arrAuctionLots(i) = AuctionLot(i, startingBid, minIncrement); % lotID, startingBid, minIncrement
end

Auction1 = AuctionSimulator(arrAuctionLots, arrBidders, maxRounds); % arrAuctionLots, arrBidders, maxRounds
Auction1.run;
%Tests
% Test on Initialization
for i = 1:numOfBidders
    arrBidders(i).toString();
end
for i = 1:numOfAuctionLot
    arrAuctionLots(i).toString();
end

