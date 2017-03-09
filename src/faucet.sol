pragma solidity ^0.4.8;

import 'erc20/erc20.sol';

contract Faucet {
    uint256 public amount = 1000;

    mapping (address => mapping (address => bool)) claimed;

    function changeAmount(uint256 amount_) {
        amount = amount_;
    }

    function claim(ERC20 token) returns (bool) {
        if (claimed[msg.sender][token]) return false;

        if (token.transfer(msg.sender, amount)) {
            claimed[msg.sender][token] = true;
        }
    }
}