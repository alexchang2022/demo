// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Token is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    string private _name;
    string private _symbol;

    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) public allowances;
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

    function initialize(string memory name_, string memory symbol_) public initializer {
      _name = name_;
      _symbol = symbol_;
      __Ownable_init();
      __UUPSUpgradeable_init();
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    function _authorizeUpgrade(address) internal override onlyOwner {}

    function name() public view returns (string memory){
	return _name;
    }

    function symbol() public view returns (string memory){
    	return _symbol;
    }

    function decimals() public pure returns (uint256){
    	return 18;
    }

    function totalSupply() public pure returns (uint256){
    	return 1000000 * 1e18;
    }

    function balanceOf(address _owner) public view returns (uint256){
    	return balances[_owner];
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        require(balances[_from] >= _value);
        require(balances[_to] + _value > balances[_to]);

        uint previousBalances = balances[_from] + balances[_to];
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        assert(balances[_from] + balances[_to] == previousBalances);
    }

    function transfer(address _to, uint _value) public returns (bool){
	_transfer(msg.sender, _to, _value);
	return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool){
    	require(_value <= allowances[_from][msg.sender]);     // 这句很重要, 地址对应的合约地址(也就是token余额)
        allowances[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool){
    	allowances[msg.sender][_spender] = _value;
	emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256){
	return allowances[_owner][_spender];
    }
}
