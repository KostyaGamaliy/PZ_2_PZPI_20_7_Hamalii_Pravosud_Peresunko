// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Exchange {

  struct Asset {
    string symbol;
    uint256 totalSupply;
  }

  struct Order {
    uint256 price;
    uint256 amount;
    address maker;
    address taker;
  }

  Asset[] public assets;
  mapping(string => Order[]) public orders;

  function createAsset(string memory symbol, uint256 totalSupply) public {
    assets.push(Asset(symbol, totalSupply));
  }

  function findAssetIndex(string memory symbol) public view returns (uint256) {
    for (uint256 i = 0; i < assets.length; i++) {
      if (keccak256(abi.encodePacked(assets[i].symbol)) == keccak256(abi.encodePacked(symbol))) {
        return i;
      }
    }

    return type(uint256).max; // Не знайдено
  }

  function placeOrder(string memory symbol, uint256 price, uint256 amount) public {
    uint256 assetIndex = findAssetIndex(symbol);
    require(assetIndex != type(uint256).max, "Asset not found");
    require(assets[assetIndex].totalSupply >= amount, "Insufficient asset supply");

    orders[symbol].push(Order(price, amount, msg.sender, address(0)));
  }

  function matchOrders(string memory symbol) public {
    for (uint256 i = 0; i < orders[symbol].length; i++) {
      Order memory makerOrder = orders[symbol][i];

      for (uint256 j = i + 1; j < orders[symbol].length; j++) {
        Order memory takerOrder = orders[symbol][j];

        if (makerOrder.price == takerOrder.price && makerOrder.amount <= takerOrder.amount) {
          makerOrder.amount = 0;
          takerOrder.amount -= makerOrder.amount;

          uint256 assetIndex = findAssetIndex(symbol);
          assets[assetIndex].totalSupply -= makerOrder.amount;
          assets[assetIndex].totalSupply += takerOrder.amount;

          makerOrder.maker = msg.sender;
          takerOrder.taker = msg.sender;
        }
      }
    }
  }
}
