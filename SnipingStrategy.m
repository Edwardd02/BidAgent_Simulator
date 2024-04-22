classdef SnipingStrategy < BiddingStrategy
    properties(Access = private)
        snipeTiming = 5;  % How close to the end of the auction to place the bid
        alpha = 200; % Controls the aggressiveness of the exponential increase
    end
    
    methods
        function obj = SnipingStrategy(snipeTiming)
            % Constructor for SnipingStrategy
            % snipeTiming should be a value indicating how many rounds from the end to place the bid
            % alpha controls the exponential rate of increment increase
            obj.snipeTiming = snipeTiming;
        end
        
        function bid = generateBid(obj, currentBid, maxBid, budget, minIncrement, roundsToLast)
            % Generate a bid based on the sniping strategy with exponential increment scaling
            if roundsToLast <= obj.snipeTiming
                % Exponential weight for roundsToLast
                weight = 1 + exp(obj.snipeTiming - roundsToLast) - rand(1);

                % Calculate the weighted minimum increment
                weightedIncrement = minIncrement * weight;

                % Time to snipe! Check if we can outbid by at least the weighted minimum increment
                if (currentBid + weightedIncrement <= budget) && (currentBid + weightedIncrement <= maxBid)
                    bid = currentBid + weightedIncrement;
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
