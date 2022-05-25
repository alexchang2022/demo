const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const TokenV1 = artifacts.require('TokenV1');

module.exports = async function (deployer) {
	deployer.deploy(TokenV1).then(function (token){
  		console.log('TokenV1 Deployed', token.address);
  		const proxy = await deployProxy(TokenV1, { deployer });
  		console.log('Proxy Deployed', proxy.address);
	});
};
