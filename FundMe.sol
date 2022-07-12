// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";
error NotOwner();


//Get fund from users
// Withdraw funds
//Set min funding value in USD


// constant and immutable keyword

contract FundMe {

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;

    }

    function fund() public payable{

        // Want to be able to set a min fund amount in USD
        // 1. How do we send ETH to this contract?
        // method to check minimum value in terms of $ which will be given by oracle like chainlink
    //    while using library
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough");



    //    without using library
        // require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
     // method to check minimum value in terms of ETH
        // require(msg.value > 1e18, "Didn't send enough"); // 1e18 == 1 *10 ** 18 == 1000000000000000000
           // What is reverting?
        // undo any action before, and send remaining gas back
    }

    

    function Withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ ){
           address funder = funders[funderIndex];
           addressToAmountFunded[funder] = 0;
        }

        //reset funders 

        funders = new address[](0);
        //withdraw fund
        //transfer
        
        // payable(msg.sender).transfer(address(this).balance);

        //send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        //Call
         (bool callSuccess,) =  payable(msg.sender).call{value: address(this).balance}("");
         require(callSuccess, "Call Failed");

    }

    modifier onlyOwner{
        // require(msg.sender == i_owner, "Sender is not owner!");
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        _;
    }

    // What happen if someone sends this contract ETH without calling the fund function
    // receive

    receive() external payable{
        fund();
    }


    // fallback

    fallback() external payable{
        fund();
    }
}
