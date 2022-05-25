const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const TokenV1 = artifacts.require('TokenV1');

module.exports = async function (deployer) {
  const instance = await deployProxy(TokenV1, { deployer });
  console.log('TokenV1 Deployed', instance.address);
};
