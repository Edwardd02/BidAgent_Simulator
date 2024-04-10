classdef SimpleIncrementStrategy < BiddingStrategy
    properties
    end
    
    methods
        function obj = SimpleIncrementStrategy()

        end
        function bid = generateBid(obj, currentBid, maxBid, budget, minIncrement, roundsToLast) % Unused arguments: budget
            proposedBid = currentBid;
            % distribute probablity for increment
            probIncrement = rand(1);
            if probIncrement<=0.5
                increment = minIncrement;
            else
                % increment = rightHalfNormalDis(minIncrement, minIncrement/10);
                increment = minIncrement + 1;
            end
            if rand(1)>0.65
                proposedBid = currentBid + increment;
            end
            bid = min([proposedBid, maxBid]);

        end

        function string = toString(obj)
            string = num2str(obj.incrementFactor);
        end
        % Function to generate one random number from the right half of the distribution
        function r = rightHalfNormalDis(mu, sigma)
            while true
                r = normrnd(mu, sigma);
                if r >= mu
                    break
                end
            end
        end

    end
end
