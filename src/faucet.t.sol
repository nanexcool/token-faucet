pragma solidity ^0.4.8;

import 'ds-test/test.sol';
import 'ds-token/base.sol';
import 'ds-token/token.sol';

import './faucet.sol';

contract User {
    Faucet faucet;
    function User(Faucet faucet_) {
        faucet = faucet_;
    }
    function set(ERC20 token, uint256 amount) {
        faucet.set(token, amount);
    }
    function claim(ERC20 token) returns (bool) {
        return faucet.claim(token);
    }
    function drain(ERC20 token) {
        return faucet.drain(token);
    }
}

contract Test is DSTest {
    Faucet      faucet;
    DSTokenBase mkr;
    DSTokenBase dai;
    User        user;

    uint256 initialBalance = 1000;

    function setUp() {
        faucet = new Faucet();
        mkr    = new DSTokenBase(initialBalance);
        dai    = new DSTokenBase(initialBalance);
        user   = new User(faucet);

        mkr.transfer(faucet, initialBalance);
        dai.transfer(faucet, initialBalance);
    }

    function testBalance() {
        assertEq(mkr.balanceOf(faucet), initialBalance);
        assertEq(dai.balanceOf(faucet), initialBalance);
        assert(faucet.hasBalance(mkr));
        assert(faucet.hasBalance(dai));
    }

    function testNoBalance() {
        ERC20 t = new DSTokenBase(0);
        assert(!faucet.hasBalance(t));
    }

    function testClaim() {
        uint256 amount = 10;
        faucet.set(mkr, amount);
        user.claim(mkr);
        assertEq(mkr.balanceOf(user), amount);
        assertEq(mkr.balanceOf(faucet), initialBalance - amount);
    }

    function testCannotClaimTwice() {
        uint256 amount = 10;
        faucet.set(mkr, amount);
        bool ok = user.claim(mkr);
        assert(ok);
        ok = user.claim(mkr);
        assert(!ok);
        assertEq(mkr.balanceOf(user), amount);
        assertEq(mkr.balanceOf(faucet), initialBalance - amount);
    }

    function testDrain() {
        faucet.drain(mkr);
        assertEq(mkr.balanceOf(faucet), 0);
        assertEq(mkr.balanceOf(this), initialBalance);
    }

    function testFailUnauthorizedSet() {
        user.set(mkr, 10);
    }

    function testFailUnauthorizedDrain() {
        user.drain(mkr);
    }
}
