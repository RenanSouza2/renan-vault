// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Vault {
    mapping(address user => bool) public hasVoted;
    mapping(address cadidate => bool) public isCandidate;
    mapping(address cadidate => uint256) public votes;
    address public winner;

    error VaultUserHasVoted(address caller);
    error VaultInvalidCandidate(address invalid);

    modifier isUser
    {
        if(hasVoted[msg.sender])
            revert VaultUserHasVoted(msg.sender);

        _;
    }

    function includeCandidate(address candidate) external {
        if(isCandidate[candidate])
            revert VaultInvalidCandidate(candidate);

        isCandidate[candidate] = true;
    }

    function vote(address candidate) external isUser {
        if(!isCandidate[candidate])
            revert VaultInvalidCandidate(candidate);

        hasVoted[msg.sender] = true;

        uint256 candidateVotes = votes[candidate];
        candidateVotes++;
        votes[candidate] = candidateVotes;

        if(candidateVotes > votes[winner])
            winner = candidate;
    }
}