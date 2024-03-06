function Main

% initialization
numOfBidders = 30;
numOfAuctionLot = 5;


strategyInstanceDefault = DefaultStrategy();

Bidders = repmat(Bidder(0, 0, 0, strategyInstanceDefault), numOfBidders, 1);

% initialized Bidders
for i = 1:numOfBidders
    Bidders(i) = Bidder(i, 10000, 100, strategyInstanceDefault);
end
for i = 1:numOfBidders
    Bidders(i).toString();
end


