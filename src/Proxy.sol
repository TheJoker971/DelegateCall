// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Proxy {

    error PERMISSION_DENIED();
    error DELEGATION_FAILED();

    uint256 count;
    mapping(address => uint256) incrementers;
    
    bytes32 private _ownerHash;
    address private delegation;


    constructor(){
        _ownerHash = keccak256(abi.encodePacked(msg.sender));
    }

    modifier _isOwner(address _sender){
        if (_ownerHash != keccak256(abi.encodePacked(_sender))){
            revert PERMISSION_DENIED();
        }
        _;
    }

    function getCount() public view returns(uint256) {
        return count;
    }

    function setDelegation(address _addr) external _isOwner(msg.sender){
        delegation = _addr;
    }

    function getIncrementOf() public view returns(uint256) {
        return incrementers[tx.origin];
    }

    fallback() external {
        (bool success,) = delegation.delegatecall(msg.data);
        if(!success){
            revert DELEGATION_FAILED();
        }
    }
}
