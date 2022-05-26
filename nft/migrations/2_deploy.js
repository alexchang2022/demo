const Items = artifacts.require('Items');
const Token = artifacts.require('Token');

module.exports = async function (deployer) {
  await deployer.deploy(Token, "Gold Token", "GOLD", "1000000000000000000000000000").then(function(token){
	console.log("ERC20 Token deployed", token.address);
  	return deployer.deploy(Items, token.address).then(function(instance){
		console.log("NFT contract deployed", instance.address);
  	});
  });
};
