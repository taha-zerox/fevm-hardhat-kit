// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NFTBoundAccount {
    // Define the mappings
    mapping(address => NFT) public nftAddresses;
    mapping(address => string) public nftStorageLocations;

    mapping(address => address) public nftOwner;

    struct NFT {
        address contractAddr;
        uint256 id;
    }

    function mintNFT(address nftAddr, string memory storageLocation) public {
        require(keccak256(abi.encodePacked(nftStorageLocations[nftAddr])) == keccak256(abi.encodePacked("")), "NFT already minted");
        nftStorageLocations[nftAddr] = storageLocation;
    }

    function associateNFT(NFT memory nft, address nftAddr) public {
        require(nftAddresses[nftAddr].contractAddr == address(0), "NFT address already associated");
        nftAddresses[nftAddr] = nft;
    }

    function getMainOwner(address nftAddress) public view returns (address) {
        address currentAddress = nftAddress;
        while (nftOwner[currentAddress] != address(0)) {
            currentAddress = nftOwner[currentAddress];
        }
        return currentAddress;
    }

    
    function transferNFT(address from, address to, address nftAddress) public {
        address mainOwner = getMainOwner(nftAddress);   
        require(mainOwner == from || from == address(0), "Only the owner can transfer the NFT, unless, the NFT is just being minted");

        nftOwner[nftAddress] = to;
        // You can implement the transfer logic here
        // This function is intentionally left empty for your custom implementation
    }
}
