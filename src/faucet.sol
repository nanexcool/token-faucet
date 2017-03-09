pragma solidity ^0.4.8;

import 'ds-auth/auth.sol';

import 'erc20/erc20.sol';

contract Faucet is DSAuth {

    mapping (address => uint256) public tokens;

    mapping (address => mapping (address => bool)) claimed;

    uint256 last_token;
    
    function next_id() internal returns (uint256) {
        last_token++;
        return last_token;
    }

    function set(ERC20 token, uint256 amount) auth {
        tokens[token] = amount;
    }

    function claim(ERC20 token) returns (bool) {
        // if (claimed[msg.sender][token]) return false;

        // if (token.transfer(msg.sender, amount)) {
        //     claimed[msg.sender][token] = true;
        // }
    }
}