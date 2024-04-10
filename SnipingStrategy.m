classdef SnipingStrategy < BiddingStrategy
    properties
        snipeTiming = 5; % How close to the end of the auction to place the bid
    end
    
    methods
        function obj = SnipingStrategy(snipeTiming)
            % Constructor for SnipingStrategy
            % snipeTiming should be a value indicating how many rounds from the end to place the bid
            obj.snipeTiming = snipeTiming;
        end
        function bid = generateBid(obj, currentBid, maxBid, budget, minIncrement, roundsToLast)
            % Generate a bid based on the sniping strategy
            if roundsToLast <= obj.snipeTiming
                % TODO: when last round is getting closer and closer, the
                % weight should be getting larger and larger
                % Time to snipe! Check if we can outbid by at least the minimum increment
                if (currentBid + minIncrement <= budget) && (currentBid + minIncrement <= maxBid)
                    bid = currentBid + minIncrement;
                else
                    % Can't bid or don't need to bid yet
                    bid = 0;
                end
            else
                % Not time to bid yet
                bid = 0;
            end
        end
    end
end