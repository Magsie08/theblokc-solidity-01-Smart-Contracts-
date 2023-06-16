// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FinalNFT is ERC721("Final NFT","FINAL"), Ownable{
    IERC20 token;
    uint256 tokenId = 1;
    uint256 public price = 0.05 ether;
    uint256 public priceErc20 = 500;
   
    function mint(address to) public payable {
         // Check if ether value is correct
        require(msg.value >= price, "Not enough ether sent.");
        _safeMint(to, tokenId);
        tokenId++;
    }

   function mintErc20(address to) public payable {
        require(msg.value >= priceErc20, "Not enough token sent.");
        _safeMint(to, tokenId);
    }

    function withdraw() public onlyOwner() {
        require(address(this).balance > 0, "Balance is zero");
        payable(owner()).transfer(address(this).balance);
    }  

    function setPrice(uint256 newPrice) public onlyOwner() {
        price = newPrice;
    }

    function setPriceErc20(uint256 newPriceErc20) public onlyOwner() {
        priceErc20 = newPriceErc20;
    }

    function getPrice() public view returns (uint256 value){
        return price;
    }

    function getPriceErc20() public view returns (uint256 value){
        return priceErc20;
    }
}