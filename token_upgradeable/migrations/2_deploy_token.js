const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Token = artifacts.require('Token');
const TokenV1 = artifacts.require('TokenV1');

module.exports = async function (deployer) {
	await deployProxy(Token, ["Token", "BCD"], {deployer}).then(async function(proxy) {
  		console.log('Proxy Deployed', proxy.address);
		// NOTE:If you want to deploy legacy token, comment out 3 lines from here.
		// This demo change token symbol from "BCD" to "GOLD"
		const proxy_new = await upgradeProxy(proxy.address, TokenV1, {deployer:deployer, call:"initializeV1"});
			console.log("Proxy New", proxy_new.address);
		});
};
