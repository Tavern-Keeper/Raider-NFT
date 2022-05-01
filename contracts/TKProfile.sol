//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract TKProfile is ERC721URIStorage, Ownable {

    struct Attributes {

        address _address;
        uint tk_id;
        string primary_skill;
        string[] achievements;
        uint[] achievement_ids;

    }
    //Discord ID => Attributes
    mapping(uint => Attributes) public TavernKeepers;
    //Tavern Keeper NFT ID counter
    uint public id = 1;
    //Achievement NFT ID Counter
    uint public achievement_id = 1;

    event TKProfileMinted(uint256 indexed discord_id, address indexed user , uint256 indexed tk_id);
    event NewAchievement(uint indexed discord_id, string achievement);
    event AchievementMinted(uint indexed discord_id, address indexed user, uint256 indexed tk_id, string achievement);

    constructor() ERC721("Tavern Keeper Profile", "TavernKeepers") {}

    //Initializes Attribute Struct with Discord ID and Primary + Secondary Skills
    function createProfile(uint discord_id, string calldata primary, address _address, string calldata metadata) public onlyOwner{

        Attributes memory tavernkeeper;
        tavernkeeper.primary_skill = primary;
        tavernkeeper._address = _address;

        TavernKeepers[discord_id] = tavernkeeper;
        mintTavernKeeper(discord_id, metadata);
    }

    //Mints TavernKeeper NFT
    function mintTavernKeeper(uint discord_id, string calldata metadata) public onlyOwner{

        TavernKeepers[discord_id].tk_id = id;
        _mint(TavernKeepers[discord_id]._address, id);
        _setTokenURI(id, metadata);


        emit TKProfileMinted(discord_id, TavernKeepers[discord_id]._address, id);
        id++;
    }

    function mintAchievement(uint discord_id, string calldata achievement, string calldata metadata) public onlyOwner{

        TavernKeepers[discord_id].achievement_ids.push(achievement_id);
        _mint(TavernKeepers[discord_id]._address, achievement_id);
        _setTokenURI(achievement_id, metadata);

        emit AchievementMinted(discord_id, TavernKeepers[discord_id]._address, achievement_id, achievement);
        achievement_id++;
    }

    function addAchievement(uint discord_id, string calldata achievement) public onlyOwner{

        TavernKeepers[discord_id].achievements.push(achievement);

        emit NewAchievement(discord_id, achievement);
    }

    function changeMetadata(uint tk_id, string calldata new_metadata) public onlyOwner{

        _setTokenURI(tk_id, new_metadata);

    }

    function viewAchievements(uint discord_id) public view  returns (string[] memory){

        return TavernKeepers[discord_id].achievements;

    }

}