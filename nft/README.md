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
- Then click write tab and connect your wallet with polyscan, call the _redeem_ function, with params: your wallet address and NFTVoucher tuple [1, "1000000000000", signature in last step].

## About
-----

_© Copyright 2022, Alex Chang_
