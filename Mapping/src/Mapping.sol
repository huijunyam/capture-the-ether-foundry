// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MappingChallenge {
    bool public isComplete;
    uint256[] public map;

    function set(uint256 key, uint256 value) public {
        map[key] = value;
    }

    function get(uint256 key) public view returns (uint256) {
        return map[key];
    }
}
