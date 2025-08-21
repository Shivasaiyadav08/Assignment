//SPDX-License-Identifier:MIT
pragma solidity ^0.8.25;

import {Script} from "forge-std/Script.sol";
import {DemoNft} from "../src/DemoNft.sol";

contract DeployDemoNft is Script {
    function run() external returns (DemoNft) {
        vm.startBroadcast();
        DemoNft demoNft = new DemoNft();
        vm.stopBroadcast();
        return demoNft;
    }
}