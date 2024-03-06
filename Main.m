function Main

% initialization
numOfBidders = 30;
numOfAuctionLot = 5;

strategyInstanceDefault = DefaultStrategy();

arrBidders = repmat(Bidder(0, 0, 0, strategyInstanceDefault), numOfBidders, 1);
arrAuctionLots = repmat(AuctionLot(0, 0, 0), numOfAuctionLot, 1);
% initializing Bidders
for i = 1:numOfBidders
    arrBidders(i) = Bidder(i, 10000, 100, strategyInstanceDefault); % bidderID, budget, maxBid, strategy
end
% initializing AuctionLots
for i = 1:numOfAuctionLot
    arrAuctionLots(i) = AuctionLot(i, 100, 10); % lotID, startingBid, minIncrement
end

%Tests
% Test on Initialization
for i = 1:numOfBidders
    arrBidders(i).toString();
end
for i = 1:numOfAuctionLot
    arrAuctionLots(i).toString();
end

