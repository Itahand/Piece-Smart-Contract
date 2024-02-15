import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"
import Piece from "../contracts/Piece.cdc"
import MetadataViews from "../contracts/standard/MetadataViews.cdc"

// This transaction configures an account to hold a Piece NFT.

transaction {
    prepare(signer: AuthAccount) {
        // if the account doesn't already have a collection

    let collectionRef = signer.borrow<&Piece.Collection>(from: Piece.CollectionStoragePath)
/*         if signer.borrow<&Piece.Collection>(from: Piece.CollectionStoragePath) == nil {

            // create a new empty collection
            let collection <- Piece.createEmptyCollection()

            // save it to the account
            signer.save(<-collection, to: Piece.CollectionStoragePath)

            // create a public capability for the collection
            signer.link<&Piece.Collection{NonFungibleToken.CollectionPublic, NonFungibleToken.Receiver, MetadataViews.ResolverCollection}>(Piece.CollectionPublicPath, target: Piece.CollectionStoragePath)
        } */
    }
}