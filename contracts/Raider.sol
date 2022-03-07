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

    event RaiderMinted(uint indexed discord_id, address indexed _address, uint indexed raider_id);
    event ProfileCreated(uint indexed discord_id);
    event ProfileAuthenticated(uint indexed discord_id, address indexed _address);

    constructor() ERC721("Raider Guild Avatars","RAIDER") {}


    //Initializes Attribute Struct with Discord ID and Primary + Secondary Skills
    function createProfile(uint discord_id, string calldata primary, string calldata secondary) public onlyOwner{

        Attributes memory raider;
        raider.primary_skill = primary;
        raider.secondary_skill = secondary;
        Raiders[discord_id] = raider;

        emit ProfileCreated(discord_id);
    }

    //Links Address to Attribute Struct
    function authenticate(uint discord_id, address _address) public {

        require(bytes(Raiders[discord_id].primary_skill).length > 0, "Profile Not Created");
        Raiders[discord_id]._address = _address;

        emit ProfileAuthenticated(discord_id, _address);
    }

    //Mints NFT
    function mintRaider(uint discord_id, string calldata uri) public onlyOwner{

        Raiders[discord_id].raider_id = id;
        _mint(Raiders[discord_id]._address, id);
        _setTokenURI(id, uri);

        emit RaiderMinted(discord_id, Raiders[discord_id]._address, id);
        id++;
    }

    function changeAvatar(uint nft_id, string calldata new_uri) public onlyOwner{

        _setTokenURI(nft_id, new_uri);
    }



}