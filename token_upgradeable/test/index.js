const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Token = artifacts.require('Token');
const TokenV1 = artifacts.require('TokenV1');

describe('upgrades', () => {
  it('works', async (done) => {
    this.timeout(10000);  //add timeout.
    const token1 = await deployProxy(Token);
    const token2 = await upgradeProxy(token1.address, TokenV1, "initializeV1");

    const value = await token2.symbol();
    assert.equal(value.toString(), 'GOLD');
  });
});
