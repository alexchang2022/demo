# ERC20 Token Upgradable 

A practical example on how to upgrade an ERC20 token


## Overview

The contracts are written in Solidity, and supports upgradeable contract. 

The goal of this code snippet is to act as a demostration of upgradeable ERC20 token. This code contains:

- Proxy contract 
- two implementation contracts 
- migration files to demostrate the upgrade process(update the symbol of token) 
- test scripts to demostrate the upgrade process 

## Requirements:

- [Openzeppelin library](https://github.com/OpenZeppelin/openzeppelin-contracts)

## Test

- The Token Proxy is [here](https://mumbai.polygonscan.com/address/0x241aFf8Cad56D43604D9EBD52A66795b350BDd1E#code).
- The upgrade transaction is [here](https://mumbai.polygonscan.com/tx/0x7445a2a132dac68adc77aa9e73924bf01074d6d5f5fc54378a61c5b7e824b623).
- The TokenV1($GOLD) implementation address is [here](https://mumbai.polygonscan.com/address/0xb3a78e4dadb05f1ba93dc48f4b7ba3205567bd1c#code).
- The Token ($BCD) implementation is [here](https://mumbai.polygonscan.com/address/0xdba562edb2a887ac05a9451c5cab54c917a73733#code).

## About

_© Copyright 2022, Alex Chang_
