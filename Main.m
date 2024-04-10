function Main
% Main function to initialize and run the auction simulation

    % Initialization of simulation parameters
    numOfBidders = 30;
    numOfAuctionLot = 2; % Assuming one auction lot for simplicity, but the structure allows for more
    minIncrementFactor = 0.01;
    maxRounds = 40;

    % Initializing AuctionLots
    arrAuctionLots = initializeAuctionLots(numOfAuctionLot, minIncrementFactor);

    % Initializing Bidders
    arrBidders = initializeBidders(numOfBidders, numOfAuctionLot, arrAuctionLots);

    % Creating and running the auction simulation
    Auction1 = AuctionSimulator(arrAuctionLots, arrBidders, maxRounds);
    Auction1.run;
end

function arrAuctionLots = initializeAuctionLots(numOfAuctionLot, minIncrementFactor)
    % Preallocates and initializes auction lots with starting bid and minimum increment
    arrAuctionLots = AuctionLot.empty(numOfAuctionLot, 0);
    for i = 1:numOfAuctionLot
        startingBid = 200; % Generate random starting bid
        minIncrement = startingBid * minIncrementFactor; % Calculate minimum increment
        actualValue = 889.4; % Unit: Dollars
        arrAuctionLots(i) = AuctionLot(i, startingBid, minIncrement, actualValue); % Initialize AuctionLot object
    end
end

function arrBidders = initializeBidders(numOfBidders, numOfAuctionLot, arrAuctionLots)
    % Preallocates and initializes bidders with their budget, max bids, and strategy
    arrBidders = Bidder.empty(numOfBidders, 0); % Preallocating empty array of objects
    for i = 1:numOfBidders
        initialMaxBids = initializeMaxBids(numOfAuctionLot, arrAuctionLots);
        budget = 100000; % A fixed budget, since the budget of a bidder doesn't really affect ebay auctions
        % incrementFactor = rand(1) * 0.05; % Generate random increment factor for strategy
        strategySimpleIncrement = SimpleIncrementStrategy; % Initialize bidding strategy
        avgSnipingTiming = 10;
        snipingTiming = 10 - leftHalfNormalDis(avgSnipingTiming, avgSnipingTiming/10); %重写
        strategySniping = SnipingStrategy(snipingTiming);
        if i <= 3 % if i <= 1, then there would be no other agents compete with it in first rounds
            arrBidders(i) = Bidder(i, budget, initialMaxBids, strategySimpleIncrement); % Initialize Bidder object
        else
            arrBidders(i) = Bidder(i, budget, initialMaxBids, strategySniping); % Initialize Bidder object
        end
    end
end

function initialMaxBids = initializeMaxBids(numOfAuctionLot, arrAuctionLots)
    % Initializes the max bids for each auction lot for a bidder
    initialMaxBids = containers.Map('KeyType', 'double', 'ValueType', 'double');
    for i = 1:numOfAuctionLot
        lotID = i;
        actualValue = arrAuctionLots(lotID).getActualValue();
        maxBid = normrnd(actualValue, actualValue/5); 
        % Generate a random value around stock price of the lot, with normal distribution
        initialMaxBids(lotID) = maxBid;
    end
end
function r = leftHalfNormalDis(mu, sigma)
    while true
        r = normrnd(mu, sigma);
        if r <= mu
            break
        end
    end
end

