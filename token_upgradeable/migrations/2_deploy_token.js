const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Token = artifacts.require('Token');
const TokenV1 = artifacts.require('TokenV1');

module.exports = async function (deployer) {
	deployProxy(Token, ["TokenV1", "BCD"], {deployer}).then(function(proxy) {
  		console.log('Proxy Deployed', proxy.address);
		const proxy_new = await upgradeProxy(proxy.address, TokenV1, ["TokenV2", "GOLD"], {deployer});
			console.log("Proxy New", proxy_new.address);
		});
};
