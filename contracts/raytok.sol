// contracts/raytok.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*
NOTE How to hash JSON Schema?:
    If owner store only uri in the contracts the token property can be lost.
    For fix this is necessary make public the json schema and others multimedia
    files used with it. The json schema can not store others uri pointing to 
    multimedia files. The json schema can only contain text fields and fields that 
    contain the hash of multimedia file. The hash of this json schema will be the 
    token hash.
*/

//TODO this must be tested with chai
contract RayToken is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => string) _tokenHashes;

    constructor() public ERC721("RayTok", "RK") {}

    function mint(address player, string memory tokenURI, string memory tokenHash)
        public onlyOwner returns (uint256)
    {
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();
        _mint(player, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        
        _tokenHashes[newTokenId] = tokenHash;

        return newTokenId;
    }

    function updateTokenURI(uint256 tokenId, string memory tokenURI)
        public onlyOwner
    {
        _setTokenURI(tokenId, tokenURI);
    }

    function getTokenHash(uint256 tokenId) public view returns (string memory)
    {
        require(tokenId > 0);
        return _tokenHashes[tokenId];
    }
}

