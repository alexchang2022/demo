# NFT redeem (ERC1155) 

A practical example on how to redeem a NFT through ERC20 token


## Overview
-----------
The contracts are written in Solidity, and supports NFT(ERC1155) redeemed. 

The goal of this code snippet is to act as a demostration of redeem NFT token. This code contains:

- NFT contract 
- test scripts to demostrate the function 

## Requirements:
--------------

- [Openzeppelin library](https://github.com/OpenZeppelin/openzeppelin-contracts)

## Test
-------
- truffle compile --all
- truffle migrate --network matic
- truffle run verify Items@nftaddress --network matic (environment variable POLYGONSCAN_API_KEY needed)
- Use [polyscan](https://mumbai.polygonscan.com/) and visit read contract tab, find voucher_hash() function, use case: your wallet address + [1, "1000000000000", "0x"] to get digest of this NFTVoucher.
- Edit file web/index.html, update the message to response value in last step, then you will get a signature popup in browser.
- Visit http://hostname/web/index.html, use MetaMask to connect the page, open developer mode in Chrome browser.
- Then click write tab and connect your wallet with polyscan, call the _redeem_ function, with params: your wallet address and NFTVoucher tuple [1, "1000000000000", __signature in last step__].
	- use MATIC, put 0.1 in value input field, which means providing 0.1 MATIC to redeem NFT
	- use Token to redeem, do not forget to call approve in Token's contract, and then put 0 in value input field. The redeem function will transfer Token from caller to the owner of NFT contract.


- NFT contract address is [here](https://mumbai.polygonscan.com/address/0x3eB4800b07b72f054Baa0d62f9DC577c983CAB05)
- redeem NFT through MATIC transaction is [here](https://mumbai.polygonscan.com/tx/0x1e6aa670e565d363ca8952b413cf28cbc606e72a5bd96c2ba53ac9be25340d9c)
- redeem NFT through Token($GOLD) transaction is [here](https://mumbai.polygonscan.com/tx/0x656c71f2ff064e2e19a50e20b2202e68a5629076b348ec37f54a91cbae26b680)
## About
-----

_© Copyright 2022, Alex Chang_
