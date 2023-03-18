// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address private owner;

    mapping(address => uint256) public balanceOf;

    constructor(uint256 _totalSupply) payable {
        owner = msg.sender;
        name = "TeamToken";
        symbol = "TM26";
        decimals = 18;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply;
    }

    function isOwner() public view returns(bool) {
        return msg.sender == owner;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(isOwner(), "Not owner");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(value <= balanceOf[msg.sender], "ERC20: insufficient balance");
        
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        
        emit Transfer(msg.sender, to, value);
        
        return true;
    }

    function mint(address to, uint256 amount) public {
        require(isOwner(), "Not owner");

        balanceOf[to] += amount;
        totalSupply += amount;

        emit Transfer(address(0), to, amount);
    }

    function airdrop(address[] memory recipients, uint256 amount) public {
        require(isOwner(), "Not owner");

        for (uint256 i = 0; i < recipients.length; i++) {
            balanceOf[recipients[i]] += amount;
            totalSupply += amount;
            emit Transfer(address(0), recipients[i], amount);
        }
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    receive () external payable {}
}
