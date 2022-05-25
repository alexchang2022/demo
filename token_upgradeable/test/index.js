const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const TokenV1 = artifacts.require('TokenV1');
const TokenV2 = artifacts.require('TokenV2');

describe('upgrades', () => {
  it('works', async () => {
    const tokenv1 = await deployProxy(TokenV1);
    const tokenv2 = await upgradeProxy(tokenv1.address, TokenV2);

    const name = await tokenv2.name();
    assert.equal(value.toString(), 'TokenV2');
  });
});
