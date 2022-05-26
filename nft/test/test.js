var Items = artifacts.require("./Items.sol");
var Token = artifacts.require("./Token.sol");

contract('Items', function(accounts) {
    var account = accounts[0];
    let contractInstance;
    let tokenInstance;
    beforeEach(async () => {
	tokenInstance = await Token.new("Test Token", "TST", "10000000000000000000000000");
        contractInstance = await Items.new(tokenInstance.address, {from: accounts[0]});
    });

    it("redeem by MATIC success", async () => {
            const result = await contractInstance.voucher_hash([1, "10000000000000000","0x"]);
            console.log("    digest = %s", result);
	    const signature = await web3.eth.sign(result.toString('hex'), account);
  	    console.log("    signature = %s", signature);
	    const ret = await contractInstance.redeem(account, [1, "10000000000000000", signature], {form: account, value: '10000000000000000'});
	    assert.equal(ret.receipt.status, true, "Redeem by ETH failed!");
    })

    it("redeem by ERC20 Token success", async () => {
            const result = await contractInstance.voucher_hash([1, "10000000000000000","0x"]);
            console.log("    digest = %s", result);
	    const signature = await web3.eth.sign(result.toString('hex'), account);
  	    console.log("    signature = %s", signature);
	    await tokenInstance.approve(contractInstance.address, "1000000000000000000000", {from: account});
	    const ret = await contractInstance.redeem(account, [1, "10000000000000000", signature], {form: account, value:0});
	    assert.equal(ret.receipt.status, true, "Redeem by ERC20 Token failed!");
    })
});
