const Items = artifacts.require('Items');
const tokenAddress = '0x241aFf8Cad56D43604D9EBD52A66795b350BDd1E';

module.exports = async function (deployer) {
  await deployer.deploy(Items, tokenAddress).then(function(instance){
	console.log("NFT contract deployed", instance.address);
  });
};
