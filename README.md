## Piece Smart Contract

This is the first step in your journey towards learning how the Piece smart contract works on the Flow network. All of the code that 
interacts with Flow is written with Cadence; a new high-level programming language intended for smart contract development.

## Table of content

- [Cadence](#cadence)
    - [Smart Contract](#smart-contract)
    - [Transactions](#transactions)
    - [Scripts](#scripts)

 ## Cadence

On Flow, we have to write and develop not only the Contract, but also the scripts and transactions to interact with them and it's all written in Cadence. 

### 1. Smart Contract

- Collection Info
  - Contract-level variables
  - Events
  - Paths
  - Contract-level nftStorage: a variable to store lost and found NFTs. 
- Structs
  - NFTMetadata: public struct that holds all the metadata related to the NFT.getCollectionAttribute
- Resources
  - NFT and Collection. 
  - MetadataStorage: all the metadata ever created is stored inside this resource.
  - Administrator: this contains all the functionality around uploading metadata to the storage, and minting and sending NFTs. It can also create other Admin resources.
    - Admin Functions
       - createNFTMetadata: takes all the params around the NFT's traits and other information, creates a struct with them and stores it inside the MetadataStorage resource.
       - mintNFT: creates a new NFT and deposits it into an address. If the address doesn't own a Piece `collection` resource, then it gets deposited inside the contract's `nftStorage`.
- Public Functions
  - isMintingAvailable: takes a creatorId and description(textContent) and returns true or false on whether the specified NFT has reached max supply or is locked down.
  - getNFTMetadata: takes a creatorId and description(textContent) and returns the NFTMetadata struct with all the metadata information about an NFT. 
  - getCollectionAttribute: takes a key and returns the selected attribute on the collection(if it exists).
  - getCollectionInfo: returns all the collection information as specified inside the public variable `collectionInfo` dictionary inside the contract.
  - resolveView: function that resolves a metadata view for this contract; takes the `Type` of the desired view and returns a structure representing the requested view.
  - createEmptyCollection.

### 2. Transactions 

- setupAccount: user signs this transaction in order to create and store a Piece collection resource.
- prepareChild: setups a Piece collection and a HybridCustody resource inside an account.
- uploadMetadata: stores an NFT's metadata inside the Piece account.
- mintNFT: mints and deposits a Piece NFT inside a user's account.
- mintMultipleNFTs: same as mintNFT, but mints the same NFT multiple times into different accounts. 
- mintMultipleListingss: same as mintMultipleNFTs, but works with multiple, different Pieces on different accounts.

### 3. Scripts

- getNFTMetadata: returns the metadata of a speficic Piece NFT.
- getCollectionInfo: returns general information around the Piece contract.
- getOwnedNFTs: collects all the Piece NFTs stored inside an account, and returns a struct of their MetadataViews.

  
    
