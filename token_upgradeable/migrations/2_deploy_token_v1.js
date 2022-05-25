const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const TokenV1 = artifacts.require('TokenV1');
const TokenV2 = artifacts.require('TokenV2');

module.exports = async function (deployer) {
	deployer.deploy(TokenV1, "TokenV1", "BCD").then(function (token){
  		console.log('TokenV1 Deployed', token.address);
		return deployProxy(TokenV1, {deployer}).then(function(proxy) {
  			console.log('Proxy Deployed', proxy.address);
			return deployer.deploy(TokenV2).then(async function (token2){
  				console.log("TokenV2 Upgraded", token2.address);
				const proxy_new = await upgradeProxy(proxy.address, TokenV2, {deployer});
				console.log("Proxy New", proxy_new.address);
			});
		});
	});
};
