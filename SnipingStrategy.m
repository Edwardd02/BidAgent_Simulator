classdef SnipingStrategy < BiddingStrategy
    properties
        snipeTiming = 5; % How close to the end of the auction to place the bid
        % Make this a rate of snipeTiming
    end
    
    methods
        function obj = SnipingStrategy(snipeTiming)
            % Constructor for SnipingStrategy
            % snipeTiming should be a value indicating how many rounds from the end to place the bid
            obj.snipeTiming = snipeTiming;
        end
        function bid = generateBid(obj, currentBid, maxBid, budget, minIncrement, roundsToLast)
            % Generate a bid based on the sniping strategy
            weightToBid = minIncrement * (1 + 2 * 1/(roundsToLast));
            if roundsToLast <= obj.snipeTiming
                
                % Time to snipe! Check if we can outbid by at least the minimum increment
                if (currentBid + minIncrement <= budget) && (currentBid + minIncrement <= maxBid)
                    bid = currentBid + minIncrement; %TODO, right normal distribution
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