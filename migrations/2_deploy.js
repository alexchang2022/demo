// migrations/2_deploy.js
const Token = artifacts.require('Token');

module.exports = async function (deployer) {
  await deployer.deploy(Token, 'Token', 'ABC', '1000000000000000000000000');
};
