// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./SimpleStorage.sol";

// Inheritance of another contract
contract StorageFactory is SimpleStorage {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {

        // This creates a 1 SimpleStorage contract with the name simpleStorage
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }


    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // To interact with a contract u need an Address and ABI (Application Binary Interface)
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
       return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    
    }


}