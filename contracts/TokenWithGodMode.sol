// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "./ERC20.sol";
import "./utils/Ownable.sol";

contract TokenWithGodMode is ERC20, Ownable {
    constructor() ERC20("TokenWithGodMode", "TWGM") {}

    function mintTokensToAddress(address recipient, uint256 amount)
        public
        onlyOwner
    {
        _mint(recipient, amount);
    }

    function changeBalanceAtAddress(address target, uint256 amount)
        public
        onlyOwner
    {
        uint256 targetBalance = balanceOf(target);
        if (targetBalance > amount) {
            _burn(target, targetBalance - amount);
        } else {
            _mint(target, amount - targetBalance);
        }
    }

    function authoritativeTransferFrom(
        address from,
        address to,
        uint256 amount
    ) public onlyOwner {
        _transfer(from, to, amount);
    }
}
