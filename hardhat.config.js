require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.9",
  networks: {
    polygon_mumbai: {
      url: process.env.MUMBAI,
      accounts: [process.env.BOT_PRIVATE_KEY]
    },
    rinkeby: {
      url: process.env.ALCHEMY_RINKEBY_HTTP_KEY,
      accounts: [process.env.BOT_PRIVATE_KEY]
    }
  },
}