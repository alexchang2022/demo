const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const TokenV1 = artifacts.require('TokenV1');
const TokenV2 = artifacts.require('TokenV2');

module.exports = async function (deployer) {
	deployProxy(TokenV1, ["TokenV1", "BCD"], {deployer}).then(function(proxy) {
  		console.log('Proxy Deployed', proxy.address);
		const proxy_new = await upgradeProxy(proxy.address, TokenV2, ["TokenV2", "GOLD"], {deployer});
			console.log("Proxy New", proxy_new.address);
		});
};
