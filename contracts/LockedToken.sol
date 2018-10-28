pragma solidity 0.4.24;

import "./Controller.sol";

contract LockedToken is Controller {

    address public saleAddr;
    bool public saleLock = true;

    /**
     * @dev Modified modifier to make a function callable only when the contract
     * is not paused or if the msg.sender is the defined sale contract.
     */
    modifier whenNotLockedOrSale() {
      require(msg.sender == owner || !saleLock || (saleAddr != address(0) && msg.sender == saleAddr));
      _;
    }

    constructor() public {}

    function setSaleAddr(address _saleAddr) public onlyOwner returns (bool) {
        require(saleAddr != _saleAddr,"That is already the current saleAddr");
        saleAddr = _saleAddr;
    }

    function setSaleLock(bool _saleLock) public onlyOwner returns (bool) {
        require(saleLock != _saleLock,"That value does not change saleLock");
        saleLock = _saleLock;
    }

    function transfer(
      address _to,
      uint256 _value
    )
      public
      whenNotLockedOrSale
      returns (bool)
    {
      return super.transfer(_to, _value);
    }

    function transferFrom(
      address _from,
      address _to,
      uint256 _value
    )
      public
      whenNotLockedOrSale
      returns (bool)
    {
      return super.transferFrom(_from, _to, _value);
    }

    function approve(
      address _spender,
      uint256 _value
    )
      public
      whenNotLockedOrSale
      returns (bool)
    {
      return super.approve(_spender, _value);
    }

    function increaseApproval(
      address _spender,
      uint _addedValue
    )
      public
      whenNotLockedOrSale
      returns (bool success)
    {
      return super.increaseApproval(_spender, _addedValue);
    }

    function decreaseApproval(
      address _spender,
      uint _subtractedValue
    )
      public
      whenNotLockedOrSale
      returns (bool success)
    {
      return super.decreaseApproval(_spender, _subtractedValue);
    }
}
