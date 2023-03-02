// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "./RoleControl.sol";

contract SBT is ERC721URIStorage, RoleControl {
    string private _ipfsPath;
    uint256 private _nextTokenId;

    event Mint(address indexed to, uint256 indexed tokenId, string metadataUri);
    event Burn(uint256 indexed tokenId);

    constructor(
        string memory name,
        string memory symbol,
        address admin
    ) ERC721(name, symbol) RoleControl(admin) {
        _ipfsPath = "ipfs://";
        _nextTokenId = 0;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(AccessControl, ERC721)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function mint(address to, string memory metadataUri) external onlyAdmin {
        uint256 tokenId = _getNextAndIncTokenId();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, metadataUri);
        emit Mint(to, tokenId, metadataUri);
    }

    function burn(uint256 tokenId) external onlyAdmin {
        _burn(tokenId);
        emit Burn(tokenId);
    }

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        require(false, "SBT: transfers are disabled");
    }

    function _baseURI()
        internal
        view
        virtual
        override(ERC721)
        returns (string memory)
    {
        return _ipfsPath;
    }

    function _getNextAndIncTokenId() internal returns (uint256) {
        return _nextTokenId++;
    }
}
