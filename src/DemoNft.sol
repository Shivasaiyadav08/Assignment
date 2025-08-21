
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;
/*
This contract is a simple NFT (Non-Fungible Token) implementation using OpenZeppelin's ERC721 standard.
*/
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
/*OWNABLE: This contract uses Ownable to restrict certain functions to the contract owner
This is useful for administrative tasks like minting new NFTs or transferring ownership.
*/
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DemoNft is ERC721 , Ownable {

    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenToUri;
    constructor() ERC721("DemoNFT", "DNFT") Ownable(msg.sender) {
        // Constructor to initialize the NFT with a name and symbol

        s_tokenCounter = 0; // Initialize the token counter to zero
    }
    /*why safe mint?
    _safeMint ensures that the minting process checks if the recipient address is valid and can receive NFTs.
    If the recipient is a contract, it must implement the onERC721Received function to accept the NFT.
    This prevents accidental loss of NFTs by trying to send them to an address that cannot handle them
    */
    function mintNft(address to , string memory tokenUri) public onlyOwner  {
        s_tokenToUri[s_tokenCounter] = tokenUri;
        _safeMint(to,s_tokenCounter);
        s_tokenCounter++;
    }
    /**
     * @dev Allows the owner to transfer an NFT to another address.
     * This function uses safeTransferFrom to ensure the recipient can handle the NFT.
     * @param from The address from which the NFT is being transferred.
     * @param to The address to which the NFT is being transferred.
     */
   function transferToken(address from, address to, uint256 tokenId) public {
    safeTransferFrom(from, to, tokenId);
 }


     function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenToUri[tokenId];
     }

     function gettokenCounter() public view returns (uint256) {
        return s_tokenCounter;
     }
}