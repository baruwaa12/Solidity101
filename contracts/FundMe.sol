// SPDX-License-Identifier: MIT

pragma solidity >= 0.6.6 < 0.9.0;

import "@contacts/artifacts/AggregatorV3Interface.sol";
import "@chainlink/contracts/srs/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    
    // Msg.sender is the sender of the function call
    // Msg.value is the amount sent.
    // Both required in every contract
    function fund() public payable {
        uint256 miniimumUSD = 50 * 10 * 18;
        addressToAmountFunded[msg.sender] += msg.value >= miniimumUSD, "You need to spend more Eth");
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer);
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount);
        return ethAmountInUSD;
    }
}