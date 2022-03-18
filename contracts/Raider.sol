//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Raider is ERC721URIStorage, Ownable {

    struct Attributes {

        address _address;
        uint raider_id;          //Raider NFT ID
        string primary_skill;    
        string secondary_skill;  
        string[] achievments;    //List of Achievements (e.g. Raids)
        uint[] achievement_ids;  //Achievement NFT ID's
        
    }
    //Discord ID => Attributes
    mapping(uint => Attributes) public Raiders;
    //Raider NFT ID counter
    uint public id = 1;

    event Mint(address from, address to, uint256 id);

    constructor() ERC721("Raider Guild Avatars","RAIDER") {}

    //Initializes Attribute Struct with Discord ID and Primary + Secondary Skills
    function createProfile(uint discord_id, string calldata primary, string calldata secondary, address _address, string calldata uri) public onlyOwner{

        Attributes memory raider;
        raider.primary_skill = primary;
        raider.secondary_skill = secondary;
        raider._address = _address;
        Raiders[discord_id] = raider;
        mintRaider(discord_id, uri);

    }

    //Links Address to Attribute Struct
    // function authenticate(uint discord_id, address _address) public {

    //     require(bytes(Raiders[discord_id].primary_skill).length > 0, "Profile Not Created");
    //     Raiders[discord_id]._address = _address;

    // }

    //Mints NFT
    function mintRaider(uint discord_id, string calldata uri) public onlyOwner{

        uint256 nft_id = id;
        Raiders[discord_id].raider_id = nft_id;
        _mint(Raiders[discord_id]._address, nft_id);
        _setTokenURI(nft_id, uri);
        emit Mint(msg.sender, Raiders[discord_id]._address, nft_id);
        id++;
    }

    function changeAvatar(uint nft_id, string calldata new_uri) public onlyOwner{

        _setTokenURI(nft_id, new_uri);

    }



}

