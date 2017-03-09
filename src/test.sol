pragma solidity ^0.4.8;

import 'ds-test/test.sol';

import './faucet.sol';

contract Test is DSTest {
    Faucet faucet;

    function setUp() {
        faucet = new Faucet();
    }

    function test_basic_sanity() {
        log_named_address('this', this);
        log_named_address('faucet', faucet);
        assert(false);
    }

    function testFail_basic_sanity() {
        assert(false);
    }
}
