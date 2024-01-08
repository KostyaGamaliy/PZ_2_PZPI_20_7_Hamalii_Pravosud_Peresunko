// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../contracts/sharing_digital_assets.sol";

contract testSuite {
    Exchange exchange = new Exchange();

    function testCreateAsset() public {
        string memory symbol = "USD";
        uint256 totalSupply = 1000000;

        exchange.createAsset(symbol, totalSupply);

        (symbol, totalSupply) = exchange.assets(0);

        Assert.equal(symbol, symbol, "Asset symbol should be 'USD'");
        Assert.equal(totalSupply, totalSupply, "Asset total supply should be 1000000");
    }

    function testFindAssetIndex() public {
        string memory symbol = "USD";
        exchange.createAsset(symbol, 1000000);

        uint256 assetIndex = exchange.findAssetIndex(symbol);
        Assert.equal(assetIndex, 0, "Asset index should be 0");

        assetIndex = exchange.findAssetIndex("EUR");
        Assert.equal(assetIndex, type(uint256).max, "Asset not found");
    }

    function testPlaceOrder() public {
        string memory symbol = "USD";
        uint256 price = 100;
        uint256 amount = 100;

        exchange.createAsset(symbol, 1000000);
        exchange.placeOrder(symbol, price, amount);

        (uint256 storedPrice, uint256 storedAmount, address maker, address taker) = exchange.orders(symbol, 0);

        Assert.equal(storedPrice, price, "Order price should be 100");
        Assert.equal(storedAmount, amount, "Order amount should be 100");
    }

    function testMatchOrders() public {
        string memory symbol = "USD";
        uint256 price = 100;
        uint256 amount = 50;

        exchange.createAsset(symbol, 1000000);
        exchange.placeOrder(symbol, price, amount);
        exchange.placeOrder(symbol, price, amount);

        exchange.matchOrders(symbol);

        (uint256 storedPrice, uint256 storedAmount, address maker, address taker) = exchange.orders(symbol, 0);

        Assert.equal(storedPrice, 0, "Price of all orders should be 0");
    }
}
    