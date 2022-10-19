// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract DeoToken is Owner {
    string public name;
    string public symbol;
    uint8 decimals = 18; 
    uint public totalSupply;
    mapping (address => uint) public balanceOf;
    
    mapping (address => 
    mapping (address => uint) ) public allowance;

    event Transfer(address indexed _from, address indexed _to,uint tokens);
    event Burnt(address indexed msg.sender, uint tokens);
    event Approval(address indexed _tokenOwner, address indexed _spender,uint tokens);

    constructor(string tokenName, string tokenSymbol, uint intialSupply) public {
        totalSupply = intialSupply*10**uint(decimals);
        balanceOf[msg.sender] = totalSupply;
        name = tokenName;
        symbol = tokenSymbol;
    }

function _transfer (address _from, address _to, uint _value) internal {
    require (_to != 0x0);
    require(balanceOf[_from] >= _value);
    require(balanceOf[_to] + _value  >= balanceOf[_to]);
    balanceOf[_from] -= _value;
    balanceOf[_to] += value;
    emit Transfer(_from,_to,_value);
    }


function transfer (address _to, uint _value) public returns (bool succes) {
    _transfer(msg.sender,_to,_value)
     return true;
}

//transfer approved allowance
function transferFrom(address _allower, address _to, uint _value) public returns (bool success){
    require(_value <= allowance[_allower][msg.sender]);
    allowance[_allower][msg.sender] -= _value;
    _transfer(_allower,_to,_value);
    return true;
}

//allow others spend your token on behalf
function approve(address _spender, uint _value) public returns (bool success){
    allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender,_value);
    return true;
}
function mintToken (address _target, uint _mintedAmt) onlyOwner{
balanceOf[_target] += _mintedAmt;
totalSupply += _mintedAmt;
emit Transfer(0,owner,_mintedAmt);
emit Transfer(owner,_target,_mintedAmt);
}

function BurnToken (uint _burnAmt) onlyOwner returns (bool success){
    require(balanceOf[msg.sender] >= _burnAmt);
    balanceOf[msg.sender] -+ _burnAmt;
    totalSupply -+ _burnAmt;
    emit Burnt(msg.sender, _burnAmt);
    return true;
}
}


contract  Owner {
public address owner;
constructor {
    owner = msg.sender;
}

modifier onlyOwner{
    require(msg.sender == owner);
    _;
}

function transferOwnerShip(address newOwner){
    owner = newOwner;
}
}