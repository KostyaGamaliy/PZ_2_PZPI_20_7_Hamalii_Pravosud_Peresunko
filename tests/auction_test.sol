// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../contracts/auction.sol";

contract testSuite {
    Auction auction = new Auction();

    function testCreateItem() public {
    
        auction.createItem("Item 1", 100, 1704377400);

        (string memory name, uint256 startingPrice, uint256 endDate, uint256 currentBid, address highestBidder) = auction.items(0);

        Assert.equal(name, "Item 1", "Item name should be 'Item 1'");
        Assert.equal(startingPrice, 100, "Starting price should be 100");
        Assert.equal(endDate, 1704377400, "End date should be 1000");
        Assert.equal(currentBid, 0, "Current bid should be 0");
    }

    function testBid() public {
        auction.createItem("Item 1", 100, 1704377400);

        (string memory name, uint256 startingPrice, uint256 endDate, uint256 currentBid, address highestBidder) = auction.items(0);
        Assert.equal(currentBid, 0, "Initial bid should be 0");
        Assert.equal(highestBidder, address(0), "Initial highest bidder should be 0x0");

        auction.bid(0, 200);

        (name, startingPrice, endDate, currentBid, highestBidder) = auction.items(0);
        Assert.equal(currentBid, 200, "Current bid should be 200");
    }

    function testGetWinner() public {
        auction.createItem("Item 1", 100, 1704377400);
        auction.bid(0, 200);
        Assert.equal(auction.getWinner(0), msg.sender, "Highest bidder should be the sender");
    }
}