pragma solidity ^0.4.8;

import 'ds-auth/auth.sol';

import 'erc20/erc20.sol';

contract FaucetEvents {
    event LogSet(address indexed token, uint256 amount);
    event LogClaim(address indexed token, address indexed who, uint256 amount);
}

contract Faucet is DSAuth, FaucetEvents {

    mapping (address => uint256) public amounts;

    mapping (address => mapping (address => bool)) claimed;

    uint256 last_token;

    function hasBalance(ERC20 token) constant returns (bool) {
        return token.balanceOf(this) > 0;
    }

    function claim(ERC20 token) returns (bool) {
        if (claimed[msg.sender][token]) return false;

        if (token.transfer(msg.sender, amounts[token])) {
            claimed[msg.sender][token] = true;
            LogClaim(token, msg.sender, amounts[token]);
            return true;
        }
    }

    function set(ERC20 token, uint256 amount) auth {
        amounts[token] = amount;
        LogSet(token, amount);
    }    

    function drain(ERC20 token) auth {
        token.transfer(msg.sender, token.balanceOf(this));
    }
}