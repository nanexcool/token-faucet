pragma solidity ^0.4.10;

import 'ds-auth/auth.sol';
import 'erc20/erc20.sol';


contract SingleFaucet is DSAuth {
    mapping (address => bool) public who;
    ERC20 gem;
    uint128 wad;
    
    function SingleFaucet(ERC20 gem_) {
        gem = gem_;
    }

    function give() {
        if (who[msg.sender]) {
            throw;
        }
        if (gem.balanceOf(this) < wad) {
            throw;
        }
        if (gem.transfer(msg.sender, wad)) {
            who[msg.sender] = true;
        }
    }

    function open(uint128 wad_) auth {
        wad = wad_;
    }

    function shut() auth {
        gem.transfer(msg.sender, gem.balanceOf(this));
    }
}