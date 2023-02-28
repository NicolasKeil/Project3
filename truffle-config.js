module.exports = {
  networks: {
    /*development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    },*/
    goerli: {
      provider: () => new HDWalletProvider(MNEMONIC /*I used the right MNEMONIC*/ , `https://goerli.infura.io/v3/74313d1fadf2479c9dcf2f62f5a05b5c`),
      network_id: 5,       // Goerli's id
      confirmations: 2,    // # of confirmations to wait between deployments. (default: 0)
      timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
       },
  },
  compilers: {
    solc: {
      version: "^0.8.19"
    }
  }
}
