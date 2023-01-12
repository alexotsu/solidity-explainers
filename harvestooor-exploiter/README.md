# Introduction
Proof of concept for how to spoof smart contract checks for things like balance, supportsInterface.

## Target: 
[Tax Harvestooor](https://etherscan.io/address/0xd60E94434310381575C5e67Bb1D3E125133AD3eD#code)

## Vector: 
Spoof the smart contract's checks for whether the attacker is actually depositing an NFT, and still receive the .00000001 ETH payout.

## Conclusion: 
This attack would be too expensive, costing ~1000x any potential reward due to the linear cost of a for loop embedded in the smart contract.