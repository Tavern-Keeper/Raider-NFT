async function main() {
    const Raider = await hre.ethers.getContractFactory("Raider");
    const raider = await Raider.deploy();
  
    await raider.deployed();
  
    console.log("Raider Skill NFT deployed to:", raider.address);
  }
  
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });

    