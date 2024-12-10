// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Proxy} from "../src/Proxy.sol";
import {Increment} from "../src/Increment.sol";

contract ProxyTest is Test {
    Proxy public proxy;
    Increment public increment;

    function setUp() public{
        proxy = new Proxy();
        increment = new Increment();
    }

    function testIncrement() public{
        proxy.setDelegation(address(increment));
        for (uint8 i;i<5;i++){
            address(proxy).call(abi.encodeWithSignature("increment()"));
        }
        assertEq(proxy.getCount(),5);
        assertEq(increment.getCount(),0);
        assertEq(proxy.getIncrementOf(),5);
    }
}
