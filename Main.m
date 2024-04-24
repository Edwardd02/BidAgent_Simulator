function Main
% Main function to initialize and run the auction simulation

    % Initialization of simulation parameters
    numOfBidders = 15;
    numOfAuctionLot = 1000;
    maxRounds = 250;
    basePrice = 890;
    startingRate = 0.35;

    % Initializing AuctionLots
    arrAuctionLots = initializeAuctionLots(numOfAuctionLot, basePrice, startingRate);

    % Initializing Bidders
    arrBidders = initializeBidders(numOfBidders, numOfAuctionLot, arrAuctionLots);

    % Creating and running the auction simulation
    Auction1 = AuctionSimulator(arrAuctionLots, arrBidders, maxRounds);
    Auction1.run;
end
% Function for initialization of AuctionLots
% basePrice: Base price used to calculate the starting bid
% multiplier: Multiplier applied to basePrice to set the starting bid
function arrAuctionLots = initializeAuctionLots(numOfAuctionLot, basePrice, startingRate)
    % Preallocates and initializes auction lots with starting bid and minimum increment

    arrAuctionLots = AuctionLot.empty(numOfAuctionLot, 0);
    for i = 1:numOfAuctionLot
        randBasePrice = normrnd(basePrice, basePrice/20);
        startingBid = startingRate * randBasePrice; % Calculate starting bid based on base price and startingRate
        minIncrement = ebayMinIncrement(startingBid); % Calculate minimum increment based on starting bid
        actualValue = randBasePrice; % Set the actual value of the lot to the base price
        arrAuctionLots(i) = AuctionLot(i, startingBid, minIncrement, actualValue); % Initialize AuctionLot object
    end
end


function arrBidders = initializeBidders(numOfBidders, numOfAuctionLot, arrAuctionLots)
    % Preallocates and initializes bidders with their budget, max bids, and strategy
    arrBidders = Bidder.empty(numOfBidders, 0); % Preallocating empty array of objects
    for i = 1:numOfBidders
        initialMaxBids = initializeMaxBids(numOfAuctionLot, arrAuctionLots);
        budget = 100000; % A fixed budget, since the budget of a bidder doesn't really affect ebay auctions
        simpleSnipingTiming = 70;
        strategySimpleIncrement = SimpleIncrementStrategy(simpleSnipingTiming); % Initialize bidding strategy
        maxSnipingTiming = 20;
        snipingTiming = maxSnipingTiming - leftHalfNormalDis(maxSnipingTiming, maxSnipingTiming/10); % 
        strategySniping = SnipingStrategy(snipingTiming);
        ratioOfStrategy = 2/15;
        if i <= ratioOfStrategy * numOfBidders
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
function minIncrement = ebayMinIncrement(biddingPrice)
    if biddingPrice >= 0.01 && biddingPrice <= 0.99
        minIncrement = 0.05;
    elseif biddingPrice >= 1.00 && biddingPrice <= 4.99
        minIncrement = 0.25;
    elseif biddingPrice >= 5.00 && biddingPrice <= 24.99
        minIncrement = 0.50;
    elseif biddingPrice >= 25.00 && biddingPrice <= 99.99
        minIncrement = 1.00;
    elseif biddingPrice >= 100.00 && biddingPrice <= 249.99
        minIncrement = 2.50;
    elseif biddingPrice >= 250.00 && biddingPrice <= 499.99
        minIncrement = 5.00;
    elseif biddingPrice >= 500.00 && biddingPrice <= 999.99
        minIncrement = 10.00;
    elseif biddingPrice >= 1000.00 && biddingPrice <= 2499.99
        minIncrement = 25.00;
    elseif biddingPrice >= 2500.00 && biddingPrice <= 4999.99
        minIncrement = 50.00;
    elseif biddingPrice >= 5000.00
        minIncrement = 100.00;
    else
        error('Invalid bidding price');
    end
end
