classdef (Abstract) Strategy
    % Strategy Interface for auction bidding strategies.
    % This abstract class defines the interface for bidding strategies.
    
    methods (Abstract)
        % Method to execute the strategy for bidding.
        % The method should determine the bid amount based on the strategy
        % and return the bid value.
        %
        % Input:
        %    obj      - The instance of the strategy class.
        %    auction  - The auction instance for which the strategy is applied.
        %    bidder   - The bidder instance applying the strategy.
        %
        % Output:
        %    bidAmount - The amount of the bid determined by the strategy.
        
        bidAmount = execute(obj, auction, bidder)
    end
end

