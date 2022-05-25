// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./TokenV1.sol";

contract TokenV2 is TokenV1{
    function initialize() initializer public {
      TokenV1.initialize("TokenV2", "EFG");
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    //constructor() initializer {}

    //function _authorizeUpgrade(address) internal override onlyOwner {}
}
