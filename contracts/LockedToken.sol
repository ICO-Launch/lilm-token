pragma solidity 0.4.24;

import "./Controller.sol";

contract LockedToken is Controller {

    mapping(address => bool) public authorized;
    bool public lock = true;

    /**
     * @dev Modified modifier to make a function callable only when the contract
     * is not paused or if the msg.sender is the defined sale contract.
     */
    modifier whenNotLockedOrAuthorized() {
      require(msg.sender == owner || !lock || authorized[msg.sender]);
      _;
    }

    constructor() public {}

    function setAuthorized(address _addr, bool _status) public onlyOwner returns (bool) {
        require(authorized[_addr] != _status,"That is already the current status");
        authorized[_addr] = _status;
    }

    function setLock(bool _lock) public onlyOwner returns (bool) {
        require(lock != _lock,"That is already the current status");
        lock = _lock;
    }

    function transfer(
      address _to,
      uint256 _value
    )
      public
      whenNotLockedOrAuthorized
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
      whenNotLockedOrAuthorized
      returns (bool)
    {
      return super.transferFrom(_from, _to, _value);
    }

    function approve(
      address _spender,
      uint256 _value
    )
      public
      whenNotLockedOrAuthorized
      returns (bool)
    {
      return super.approve(_spender, _value);
    }

    function increaseApproval(
      address _spender,
      uint _addedValue
    )
      public
      whenNotLockedOrAuthorized
      returns (bool success)
    {
      return super.increaseApproval(_spender, _addedValue);
    }

    function decreaseApproval(
      address _spender,
      uint _subtractedValue
    )
      public
      whenNotLockedOrAuthorized
      returns (bool success)
    {
      return super.decreaseApproval(_spender, _subtractedValue);
    }
}
