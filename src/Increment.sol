// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Increment {

    uint256 count;
    mapping(address => uint256) incrementers;

    constructor(){}

    function increment() public{
        count++;
        incrementers[tx.origin]++;
    }

    function getCount() public view returns(uint256) {
        return count;
    }
}