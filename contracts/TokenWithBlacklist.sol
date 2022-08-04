// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "./ERC20.sol";
import "./utils/Ownable.sol";

contract TokenWithBlacklist is ERC20, Ownable {
    mapping(address => bool) private _blacklist;

    constructor() ERC20("TokenWithBlacklist", "TWBL") {}

    function addToBlacklist(address _user) public onlyOwner {
        require(!_blacklist[_user], "User is already on the blacklist.");
        _blacklist[_user] = true;
    }

    function removeFromBlacklist(address _user) public onlyOwner {
        require(_blacklist[_user], "User is not on the blacklist.");
        delete _blacklist[_user];
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        require(!_blacklist[from], "Sending address is blacklisted.");
        require(!_blacklist[to], "Receiving address is blacklisted");
    }
}
