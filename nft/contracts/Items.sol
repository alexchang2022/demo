// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";        // ERC20 interface
import "@openzeppelin/contracts/access/Ownable.sol";            // OZ: Ownable
import "@openzeppelin/contracts/utils/math/SafeMath.sol";       // OZ: SafeMath
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";  // OZ: ReentrancyGuard


contract Items is ERC1155, ReentrancyGuard, Ownable {
    using SafeMath for uint256;

    // max NFT can be redeemed
    uint256 public nftMinted;
    IERC20 public immutable erc20Token;

    struct NFTVoucher {
	    uint256 tokenId; // The token id to be redeemed
	    uint256 minPrice; // The min price the caller has to pay in order to redeem
	    bytes signature; // The typed signature generated beforehand
    }

    /**
     * Events
     */
    event RedeemNFTByETH(address indexed account, uint256 indexed tokenId, uint256 fee_amount);
    event RedeemNFTByToken(address indexed account, uint256 indexed tokenId, uint256 fee_amount);

    /**
     *
     *  @dev _erc20TokenAddress The contract address of token required to redeem NFT, proxy contract address in token_upgradeable. 
     */
    constructor(address _erc20TokenAddress) ERC1155("https://gamefibox.club/meta/item/{id}.json") {
	erc20Token = IERC20(_erc20TokenAddress);
	nftMinted = 0;
    }

    // Redeem NFT by Token 
    function redeem(address redeemer, NFTVoucher calldata voucher) public nonReentrant returns (bool) {
	require(redeemer != address(0), "invalid redeemer");
	// TODO: verify signature

        require(erc20Token.balanceOf(msg.sender) >= voucher.minPrice, "INSUFFICIENT MINT COST TOKEN");

	erc20Token.transferFrom(msg.sender, owner(), voucher.minPrice);

	uint256 tokenId = voucher.tokenId;

        payable(owner()).transfer(msg.value);
	nftMinted = nftMinted.add(1);
        _mint(redeemer, tokenId, 1, "");

        emit RedeemNFTByToken(msg.sender, tokenId, voucher.minPrice);

        return true;
    }

    // Redeem NFT by ETH/BNB/MATIC
    function redeemByETH(address redeemer, NFTVoucher calldata voucher) public payable nonReentrant returns (bool) {
	require(redeemer != address(0), "invalid redeemer");
	// TODO: verify signature

        require(msg.value >= voucher.minPrice, "INSUFFICIENT MINT COST ETH");
	
	uint256 tokenId = voucher.tokenId;

        payable(owner()).transfer(msg.value);
	nftMinted = nftMinted.add(1);
        _mint(redeemer, tokenId, 1, "");

        emit RedeemNFTByETH(msg.sender, tokenId, msg.value);

        return true;
    }
}
