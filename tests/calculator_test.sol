// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../contracts/calculator.sol";

contract testSuite {
    Calculator calculator = new Calculator();

    function add() public {
        Assert.ok(calculator.add(1, 2) == 3, 'should be true');
        Assert.ok(calculator.add(100, 200) == 300, 'should be true');
    }

    function subtract() public {
        Assert.ok(calculator.subtract(2, 1) == 1, 'should be true');
        Assert.ok(calculator.subtract(200, 50) == 150, 'should be true');
    }

    function multiply() public {
        Assert.ok(calculator.multiply(1, 2) == 2, 'should be true');
        Assert.ok(calculator.multiply(100, 200) == 20000, 'should be true');
    }

    function divide() public {
        Assert.ok(calculator.divide(10, 5) == 2, 'should be true');
        Assert.ok(calculator.divide(300, 100) == 3, 'should be true');
    }
}
    