classdef AuctionSimulator
    properties
        auctionLots   % Array of Product objects
        bidders       % Array of Bidder objects
        maxRounds     % Maximum number of bidding rounds
        gpModel       % Gaussian Process Model
        bidsHistory   % Cell array to store the history of bids for each auction lot
    end
    
    methods
        % Constructor method to initialize the simulation
        function obj = AuctionSimulator(auctionLots, bidders, maxRounds)
            obj.auctionLots = auctionLots;
            obj.bidders = bidders;
            obj.maxRounds = maxRounds;
            obj.gpModel = [];  % Initialize GP model as empty
            obj.bidsHistory = cell(numel(auctionLots), 1); % Initialize bids history
            for i = 1:numel(auctionLots)
                obj.bidsHistory{i} = []; % Initialize empty array for each auction lot
            end
        end
        
        % Method to run the simulation
        function run(obj)
            figure; % Initialize figure for visualization
            numLots = numel(obj.auctionLots);
            for lotIndex = 1:numLots
                ProcessingDisp = ['Simluating Bidding: Now at lot: ' , num2str(lotIndex), ', ', num2str(numLots-lotIndex), ' lots left'];
                disp(ProcessingDisp);
                bidsOverRounds = zeros(1, obj.maxRounds); % Track bids for each round
                bidsOverRounds = obj.processBiddingForLot(lotIndex, bidsOverRounds);
                % After processing each lot, store the bids in the history
                obj.bidsHistory{lotIndex} = bidsOverRounds;
            end
            % Gaussian Process
            obj.gpFusionAndPlot;
        end
        % Model-Based Fusion: Fit a model (Gaussian Process Regression)
        % to the bid data of each lot, then use the models to generate a
        % fused curve at each round.
        function gpFusionAndPlot(obj)
            numLots = numel(obj.auctionLots);
            allPredictions = [];
            for i = 1:numLots
                ProcessingDisp = ['Curve Fusion: Now at lot: ' , num2str(i), ', ', num2str(numLots - i), ' lots left'];
                disp(ProcessingDisp);
                % Extract the bid data for the current lot
                bidData = obj.bidsHistory{i};
                bidData = bidData./890;
                % Transpose if bidData is a row vector
                if size(bidData, 1) == 1  
                    bidData = bidData';
                end
                rounds = (1:numel(bidData))';
                rounds = rounds./250.*60;
                obj.gpModel = fitrgp(rounds, bidData, 'KernelFunction', 'squaredexponential', 'Standardize', true);
        
                % Predict bids for each round using the GP model
                [predictions, ~] = predict(obj.gpModel, rounds);
        
                % Store predictions
                allPredictions = [allPredictions, predictions];

            end
        
            % Calculate the fused prediction (mean across all lots)
            fusedPrediction = mean(allPredictions, 2);
        
            % Plot the fused curve
            figure;
            plot(rounds, fusedPrediction, '-o', 'LineWidth', 2);
            title('Fused GP Prediction Curve');
            xlabel('Round');
            ylabel('Bid Amount');
        end
    end
    
    methods (Access = private)
        % Helper method to process bidding for a single auction lot
        function bidsOverRounds = processBiddingForLot(obj, lotIndex, bidsOverRounds)
            % Loop through each bidding round up to the maximum rounds set for the auction
            for round = 1:obj.maxRounds
                % Call processRound method to handle the bidding for this round and lot,
                % and capture the highest bid made during the round
                highestBid = processRound(obj, lotIndex, round);
        
                % Store the highest bid of the current round in the bidsOverRounds array
                bidsOverRounds(round) = highestBid;
                
        
                % Update the plot with the new bid information for visualization
                % Plotting Function
                % obj.updatePlot(lotIndex, round, bidsOverRounds);

                % Update the minIncrement of auction lot
                obj.auctionLots(lotIndex).setMinIncrement(obj.ebayMinIncrement(highestBid));
            end
    
            % After all rounds have been processed for this lot,
            % call announceWinners to display the winner and their bid
            % obj.announceWinners(lotIndex);
        end

        
        function highestBid = processRound(obj, lotIndex, round)
            highestBid = obj.auctionLots(lotIndex).getCurrentBid(); % Initialize with the current highest bid for the lot
            leadingBidderIndex = obj.auctionLots(lotIndex).getLeadingBidder();
            isUpdated = 0;
           for bidderIndex = 1:length(obj.bidders)
            % Simulate bid by each bidder
                currentBid = obj.bidders(bidderIndex).placeBid(obj.auctionLots(lotIndex), round, obj.maxRounds).getCurrentBid;
                % Check if the current bid is higher than the highest bid so far
                if currentBid > highestBid
                    isUpdated = 1;
                    highestBid = currentBid; % Update highest bid
                    leadingBidderIndex = bidderIndex; % Update leading bidder
                end
           end
           if isUpdated
                obj.auctionLots(lotIndex).setCurrentBid(highestBid); % Update the lot's current highest bid
                obj.auctionLots(lotIndex).setLeadingBidder(obj.bidders(leadingBidderIndex).getID); % Update the leading bidder to lot
                isUpdated = 0;
           end
        end

        
        % Update plot for each round
        function updatePlot(obj, lotIndex, round, bidsOverRounds)
            subplot(length(obj.auctionLots), 1, lotIndex);
            plot(1:round, bidsOverRounds(1:round), '-o');
            title(['Auction Lot ', num2str(lotIndex)]);
            xlabel('Round');
            ylabel('Bid Amount');
            drawnow; % Refresh the plot
            %pause(0.5); % Short pause for visualization
        end
        
        % Announce winners and maximum bidders after the final round
        function announceWinners(obj, lotIndex)
            winnerID = obj.auctionLots(lotIndex).getLeadingBidder;
            lotID = obj.auctionLots(lotIndex).getID;
            largestMaxBidID = -1;
            largestMaxBid = -1;

            % Find the bidder with the largest max bid for this lot
            for bidderIndex = 1:length(obj.bidders)
                mapMaxBid = obj.bidders(bidderIndex).getMaxBidding;
                if largestMaxBid < mapMaxBid(lotIndex)
                    largestMaxBid = mapMaxBid(lotIndex);
                    largestMaxBidID = obj.bidders(bidderIndex).getID;
                end
            end

            % Print details about the largest max bid
            fprintf('Bidder with ID: %d, has the largest max bid on Lot: %d, the max bid is: %.2f\n\n', largestMaxBidID, lotID, largestMaxBid);

            % If there is a winner, announce them and adjust their budget
            if winnerID ~= -1
                finalPrice = obj.auctionLots(lotIndex).getCurrentBid;
                fprintf('Bidder with ID: %d, won the lot with ID: %d, with a final bid of: %.2f dollars.\n\n', winnerID, lotID, finalPrice);
        
                % Update the winner's budget
                winnerBudget = obj.bidders(winnerID).getBudget - finalPrice;
                obj.bidders(winnerID).setBudget(winnerBudget);
            else
                fprintf('Failed to sell at this auction lot, lot ID: %d\n', lotID);
            end
        end
        

        % function for calculating ebay auction minimum incremnet
        function minIncrement = ebayMinIncrement(obj, biddingPrice)
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
    end
end


