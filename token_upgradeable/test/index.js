const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Token = artifacts.require('Token');
const TokenV1 = artifacts.require('TokenV1');

contract('Token', function(accounts){
  let proxyInstance;
  it('Upgradeable contract success', async () => {
    proxyInstance = await deployProxy(Token, ["Token", "BCD"]);
    console.log("	Proxy Address : %s", proxyInstance.address);
    console.log("	Token Name: %s, Token Symbol: %s", await proxyInstance.name(), await proxyInstance.symbol());

    proxyInstance = await upgradeProxy(proxyInstance.address, TokenV1, {kind:"uups", call:"initializeV1"});
    console.log("	Proxy Address : %s", proxyInstance.address);
    console.log("	New Token Name: %s, Token Symbol: %s", await proxyInstance.name(), await proxyInstance.symbol());

    const value = await proxyInstance.symbol();
    assert.equal(value.toString(), "GOLD");
  });
});
