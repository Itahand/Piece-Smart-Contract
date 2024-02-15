#allowAccountLinking

import HybridCustody from "../contracts/hybridCustody/HybridCustody.cdc"
import CapabilityFactory from "../contracts/hybridCustody/CapabilityFactory.cdc"
import CapabilityFilter from "../contracts/hybridCustody/CapabilityFilter.cdc"

import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import MetadataViews from "../contracts/standard/MetadataViews.cdc"
import Piece from "../contracts/Piece.cdc"

// This transaction configures an account to hold a Piece NFT
// and to be a child account with capability access to Piece NFTs.

transaction() {
    prepare(childAccount: AuthAccount) {

        //
        //// SETUP PIECE COLLECTION 
        //

        if childAccount.borrow<&Piece.Collection>(from: Piece.CollectionStoragePath) == nil {

            // create a new empty collection
            let collection <- Piece.createEmptyCollection()

            // save it to the account
            childAccount.save(<-collection, to: Piece.CollectionStoragePath)

            // create a public capability for the collection
            childAccount.link<&Piece.Collection{NonFungibleToken.CollectionPublic, NonFungibleToken.Receiver, MetadataViews.ResolverCollection}>(Piece.CollectionPublicPath, target: Piece.CollectionStoragePath)
        }

        //
        //// SETUP CHILD RESOURCE 
        //
        
        var acctCap: Capability<&AuthAccount> = childAccount.getCapability<&AuthAccount>(HybridCustody.LinkedAccountPrivatePath)
        if !acctCap.check() {
            acctCap = childAccount.linkAccount(HybridCustody.LinkedAccountPrivatePath)!
        }

        if childAccount.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath) == nil {
            let ownedAccount <- HybridCustody.createOwnedAccount(acct: acctCap)
            childAccount.save(<-ownedAccount, to: HybridCustody.OwnedAccountStoragePath)
        }

        // check that paths are all configured properly
        childAccount.unlink(HybridCustody.OwnedAccountPrivatePath)
        childAccount.link<&HybridCustody.OwnedAccount{HybridCustody.BorrowableAccount, HybridCustody.OwnedAccountPublic, MetadataViews.Resolver}>(HybridCustody.OwnedAccountPrivatePath, target: HybridCustody.OwnedAccountStoragePath)

        childAccount.unlink(HybridCustody.OwnedAccountPublicPath)
        childAccount.link<&HybridCustody.OwnedAccount{HybridCustody.OwnedAccountPublic, MetadataViews.Resolver}>(HybridCustody.OwnedAccountPublicPath, target: HybridCustody.OwnedAccountStoragePath)

        //let child = childAccount.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath)
        let child = childAccount.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath)
            ?? panic("child account not found")

        let thumbnail = MetadataViews.HTTPFile(url: "https://www.piece.gg/static/media/logo.48da6adac82863dd4955abe125b5c8dd.svg")
        let display = MetadataViews.Display(name: "Piece", description: "Sell Pieces of any Tweet in seconds.", thumbnail: thumbnail)
        child.setDisplay(display)

        childAccount.link<&Piece.Collection{NonFungibleToken.Provider, NonFungibleToken.CollectionPublic}>(/private/PieceCollection, target: Piece.CollectionStoragePath)
        childAccount.link<&Piece.Collection{NonFungibleToken.CollectionPublic}>(/public/PieceCollection, target: Piece.CollectionStoragePath)
  
    
    }
}