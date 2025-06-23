const Web3 = require('web3');

class VotingDApp {
  constructor(contractAddress, abi) {
    this.web3 = new Web3(window.ethereum); // assumes MetaMask
    this.contract = new this.web3.eth.Contract(abi, contractAddress);
  }

  async createProposal(description) {
    const accounts = await this.web3.eth.getAccounts();
    await this.contract.methods.createProposal(description).send({ from: accounts[0] });
  }

  async vote(proposalId, support) {
    const accounts = await this.web3.eth.getAccounts();
    await this.contract.methods.vote(proposalId, support).send({ from: accounts[0] });
  }

  async getResults(proposalId) {
    const result = await this.contract.methods.getResults(proposalId).call();
    return {
      description: result[0],
      yesVotes: result[1],
      noVotes: result[2]
    };
  }
}