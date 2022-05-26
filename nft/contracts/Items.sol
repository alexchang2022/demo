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
    bytes32 public DOMAIN_SEPARATOR;

    struct NFTVoucher {
	    uint256 tokenId; // The token id to be redeemed
	    uint256 minPrice; // The min price the caller has to pay in order to redeem
	    bytes signature; // The typed signature generated beforehand
    }

    bytes32 constant VOUCHER_TYPEHASH = keccak256(
        "NFTVoucher(uint256 tokenId,uint256 minPrice)"
    );

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
	uint chainId;
        assembly {
            chainId := chainid()
        }
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
                keccak256(bytes('Items')),
                keccak256(bytes('1')),
                chainId,
                address(this)
            )
        );
    }
    /**
     * @dev compute the signature of NFTVoucher
     */
    function hash(NFTVoucher memory voucher) internal pure returns (bytes32) {
        return keccak256(abi.encode(
            VOUCHER_TYPEHASH,
	    voucher.tokenId,
            voucher.minPrice
        ));
    }

    /**
     * @dev get the digest of Voucher 
     */
    function voucher_hash(NFTVoucher memory voucher) public view returns (bytes32) {
        bytes32 digest = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            hash(voucher)
        ));
	return digest;
    }

    /**
     * @dev verify voucher
     */
    function verify(address redeemer, NFTVoucher memory voucher, uint8 v, bytes32 r, bytes32 s) internal view returns (bool) {
        // Note: we need to use `encodePacked` here instead of `encode`.
        bytes32 digest = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            hash(voucher)
        ));
	bytes memory prefix = "\x19Ethereum Signed Message:\n32";
     	digest = keccak256(abi.encodePacked(prefix, digest));
        return ecrecover(digest, v, r, s) == redeemer;
    }

    // Redeem NFT by Token 
    function redeem(address redeemer, NFTVoucher calldata voucher) public payable nonReentrant returns (bool) {
	require(redeemer != address(0), "invalid redeemer");
	require(voucher.tokenId != 0 && voucher.minPrice != 0, "invalid voucher");
	// FIXME: verify signature, need a better method
	bytes32 r;
    	bytes32 s;
    	uint8 v;
	require(voucher.signature.length == 65, "invalid signature");

	bytes memory sig = voucher.signature;
    	assembly {
      		r := mload(add(sig, 32))
      		s := mload(add(sig, 64))
      		v := and(mload(add(sig, 65)), 255)
    	}

	// https://github.com/ethereum/go-ethereum/issues/2053
    	if (v < 27) {
      		v += 27;
    	}
    	require(v == 27 || v == 28, "invalid v");
	require(verify(redeemer, voucher, v, r, s), "invalid voucher signature");

	// redeem by ETH/MATIC/BNB
	if(msg.value >= voucher.minPrice)
	{
		payable(owner()).transfer(msg.value);
		nftMinted = nftMinted.add(1);
		_mint(redeemer, voucher.tokenId, 1, "");

		emit RedeemNFTByETH(msg.sender, voucher.tokenId, msg.value);

		return true;
	}

        require(erc20Token.balanceOf(msg.sender) >= voucher.minPrice, "INSUFFICIENT MINT COST TOKEN");

	erc20Token.transferFrom(msg.sender, owner(), voucher.minPrice);

	uint256 tokenId = voucher.tokenId;

        payable(owner()).transfer(msg.value);
	nftMinted = nftMinted.add(1);
        _mint(redeemer, tokenId, 1, "");

        emit RedeemNFTByToken(msg.sender, tokenId, voucher.minPrice);

        return true;
    }
}
