// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {Test} from "forge-std/Test.sol";
import {DemoNft} from "../src/DemoNft.sol";

contract DemoNftTest is Test {
    DemoNft public demoNft;
    address public Alice = makeAddr("Alice");
    address public Bob = makeAddr("Bob");

    function setUp() public {
       
        demoNft = new DemoNft();
    }

   
    function testMintNft() public {
        string memory uri = "https://example.com/token1";

        
        demoNft.mintNft(Alice, uri);

       
        assertEq(demoNft.ownerOf(0), Alice);
        assertEq(demoNft.tokenURI(0), uri);
    }

    function testTokenCounterIncrement() public {
        uint256 initialCounter = demoNft.gettokenCounter();
        demoNft.mintNft(Alice, "https://example.com/token1");
        assertEq(demoNft.gettokenCounter(), initialCounter + 1);
    }

    function testTransferNft() public {
        demoNft.mintNft(Alice, "https://example.com/token3");
        vm.startPrank(Alice); 
        uint256 tokenId = demoNft.gettokenCounter() - 1;
        demoNft.transferToken(Alice, Bob, tokenId);
        vm.stopPrank();

        assertEq(demoNft.ownerOf(tokenId), Bob);
    }
    function testOnlyOwnerCanMint() public {
        vm.startPrank(Alice);
        vm.expectRevert(); 
        demoNft.mintNft(Alice, "https://example.com/fail");
        vm.stopPrank();
    }
}
