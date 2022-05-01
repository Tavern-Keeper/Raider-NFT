async function main() {
    const TavernKeeper = await hre.ethers.getContractFactory("TKProfile");
    const tavernkeeper = await TavernKeeper.deploy();

    await tavernkeeper.deployed();

    console.log("Raider Skill NFT deployed to:", tavernkeeper.address);
  }


  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });

