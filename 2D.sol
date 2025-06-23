// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Proposal {
        string description;
        uint voteCountYes;
        uint voteCountNo;
    }

    Proposal[] public proposals;
    mapping(address => mapping(uint => bool)) public hasVoted;

    event ProposalCreated(uint proposalId, string description);
    event Voted(uint proposalId, address voter, bool support);

    function createProposal(string memory _description) public {
        proposals.push(Proposal(_description, 0, 0));
        emit ProposalCreated(proposals.length - 1, _description);
    }

    function vote(uint _proposalId, bool _support) public {
        require(_proposalId < proposals.length, "Invalid proposal");
        require(!hasVoted[msg.sender][_proposalId], "Already voted");

        hasVoted[msg.sender][_proposalId] = true;

        if (_support) {
            proposals[_proposalId].voteCountYes++;
        } else {
            proposals[_proposalId].voteCountNo++;
        }

        emit Voted(_proposalId, msg.sender, _support);
    }

    function getResults(uint _proposalId) public view returns (string memory, uint, uint) {
        require(_proposalId < proposals.length, "Invalid proposal");
        Proposal memory p = proposals[_proposalId];
        return (p.description, p.voteCountYes, p.voteCountNo);
    }
}