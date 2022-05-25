const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const TokenV1 = artifacts.require('TokenV1');
const TokenV2 = artifacts.require('TokenV2');

module.exports = async function (deployer) {
  const existing = await TokenV1.deployed();
  const instance = await upgradeProxy(existing.address, TokenV2, { deployer });
  console.log("TokenV2 Upgraded", instance.address);
};
