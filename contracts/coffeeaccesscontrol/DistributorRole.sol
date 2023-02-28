//SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "./Roles.sol";


contract ConsumerRole{

    event DistributorAdded (address indexed account ); //indexed is for event filtering in Ethereum --> later we can search for an event but is not stored in the blockchain since gas costs wants to be saved
    event DistributorRemoved (address indexed account );

    using Roles for Roles.Role; //using ^= import
    Roles.Role private distributors;

    constructor () public {
        _addDistributor(msg.sender);
    }

    modifier onlyDistributor(){//to check if the sender or an actor really a distributor
        require(isDistributor(msg.sender));
        _;
    }

    function isDistributor (address account) public view returns (bool){
        return distributors.has(account); //has is from the Roles.sol library
    }

    function addDistributor (address account) public onlyDistributor {
        _addDistributor(account);
    }

    function renounceDistributor () public {
        _removeDistributor(msg.sender);
    }

    function _addDistributor (address account) internal { //_ --> private function --> can't be seen when deployed on the API
        distributors.add(account);
        emit DistributorAdded(account);
    }

    function _removeDistributor (address account) internal {
        distributors.remove(account);
        emit DistributorRemoved(account);
    }

}