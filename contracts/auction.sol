// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Auction {

  struct Item {
    string name;
    uint256 startingPrice;
    uint256 endDate;
    uint256 currentBid;
    address highestBidder;
  }

  Item[] public items;

  function createItem(string memory name, uint256 startingPrice, uint256 endDate) public {
    items.push(Item(name, startingPrice, endDate, 0, address(0)));
  }

  function bid(uint256 itemId, uint256 amount) public {
    Item storage item = items[itemId];
    if (item.endDate > block.timestamp) {
      if (amount > item.currentBid) {
        item.currentBid = amount;
        item.highestBidder = msg.sender;
      }
    }
  }

  function getWinner(uint256 itemId) public view returns (address) {
    Item storage item = items[itemId];
    if (item.endDate < block.timestamp) {
      return item.highestBidder;
    } else {
      return address(0);
    }
  }
}