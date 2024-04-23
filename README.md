# Online Auction Simulation Program
MATH-2121-Spring-2024-Project 

## Overview
- This MATLAB program simulates an auction system where multiple bidders participate in bidding for a set number of auction lots. It utilizes object-oriented programming to model auction dynamics, applying various bidding strategies and calculating bid increments based on predefined rules.

## Installation
- No installation is required beyond a working MATLAB environment. Download the `.m` files associated with the program and run them in MATLAB.

## Usage
- Execute the `Main` function to start the simulation:
```
Main
```
- This initializes the auction environment, including bidders and auction lots, and runs the simulation through a series of bids managed by an `AuctionSimulator` object.

## Key Components
- **AuctionSimulator**: Manages the auction, tracks bids, and visualizes results.
- **AuctionLot**: Represents an individual lot including details like starting bid and current highest bid.
- **Bidder**: Represents auction participants, each with unique bidding strategies.
- **BiddingStrategy**: Abstract class for different bidding strategies.
- **SnipingStrategy and SimpleIncrementStrategy**: Concrete strategies for bidding.

## Functions
- **initializeAuctionLots(numOfAuctionLot, basePrice, startingRate)**: Initializes lots with randomized values based on a base price.
- **initializeBidders(numOfBidders, numOfAuctionLot, arrAuctionLots)**: Prepares bidders with strategies and initial budgets.
- **ebayMinIncrement(biddingPrice)**: Determines the minimum bid increment.

## Parameters
- `numOfBidders`: Number of bidders.
- `numOfAuctionLot`: Number of lots.
- `maxRounds`: Max bidding rounds per lot.
- `basePrice`: Base price for lot values.
- `startingRate`: Multiplier for starting bid.

## Modifying Simulation Settings
- Adjust `numOfBidders`, `numOfAuctionLot`, and `maxRounds` in `Main` to change the simulation's scale and complexity.

## References
- https://www.ebay.com/help/buying/bidding/automatic-bidding?id=4014
- https://www.jstor.org/stable/pdf/3083298.pdf?refreqid=fastly-default%3A1020d6db6d43fa0ee699c717169dda9d&ab_segments=&origin=&initiator=&acceptTC=1
- https://web.stanford.edu/~alroth/papers/eBay.ai.pdf
- https://www.stat.berkeley.edu/~aldous/Research/Ugrad/selene_xu.pdf
