/**
 * SPDX-License-Identifier: GPL-3.0-or-later
 * Hegic
 * Copyright (C) 2020 Hegic Protocol
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import "./HegicStaking.sol";
pragma solidity 0.6.12;


contract HegicStakingETH is HegicStaking, IHegicStakingETH {
    using SafeMath for uint;

    constructor(ERC20 _token) public
        HegicStaking(_token, "HEGIC ETH Staking lot", "hlETH") {}

    function sendProfit() external payable override {
        uint _totalSupply = totalSupply();
        if (_totalSupply > 0) {
            totalProfit += msg.value.mul(ACCURACY) / _totalSupply;
            emit Profit(msg.value);
        } else {
            FALLBACK_RECEPIENT.transfer(msg.value);
        }
    }

    function _transferProfit(uint amount) internal override {
        msg.sender.transfer(amount);
    }
}