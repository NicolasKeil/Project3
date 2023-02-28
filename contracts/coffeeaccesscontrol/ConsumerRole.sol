//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./Roles.sol"; 

contract ConsumerRole {
    event ConsumerAdded(address account); //event for adding and removing a consumer
    event ConsumerRemoved (address account); 

    using Roles for Roles.Role;
    Roles.Role private consumers; //inheritaded struct from the library Roles.sol

    constructor () public {
        _addConsumer(msg.sender);
    }

    modifier  OnlyConsumer () {
        require(isConsumer(msg.sender));
    _;
    }

    function isConsumer (address account) public view returns (bool){
        return consumers.has(account); //has is from the Roles.sol library
    }

    function addConsumer (address account) public OnlyConsumer { //calling the modifier
        _addConsumer(account); //adding _ as a prefix; method is defined later
    }

    function renounceConsumer () public { //consumer should be able to take back their role
        _removeConsumer(msg.sender); //msg.sender bc this is the person who is sending the tx to the smart contract
    }

    function _addConsumer(address account) internal{
        consumers.add(account);
        emit ConsumerAdded(account); //to call the event --> to notify any interested parties that a consumer role is added
    }

    function _removeConsumer(address account) internal {
        consumers.remove(account);
        emit ConsumerRemoved(account);
    }

}