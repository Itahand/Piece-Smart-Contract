import Piece from "../contracts/Piece.cdc"
import MetadataViews from "../contracts/standard/MetadataViews.cdc"
import NonFungibleToken from "../contracts/standard/NonFungibleToken.cdc"


transaction(recipientAddress: Address) {
    let signerCollection: &Piece.Collection
    let RecipientCollection: &Piece.Collection{NonFungibleToken.CollectionPublic}


    prepare(signer: AuthAccount) {
        self.signerCollection = signer.borrow<&Piece.Collection>(from: Piece.CollectionStoragePath)!
                      
/*         self.signerCollection = signer.borrow<&Piece.Collection{NonFungibleToken.Provider}>(from: Piece.CollectionStoragePath)
                                ?? panic("This user does not have a Collection.") */

        self.RecipientCollection = getAccount(recipientAddress).getCapability(Piece.CollectionPublicPath)
                                .borrow<&Piece.Collection{NonFungibleToken.CollectionPublic}>()!
    }

    execute {
        let ids = self.signerCollection.getIDs()

        for id in ids {

            self.RecipientCollection.deposit(token: <- self.signerCollection.withdraw(withdrawID: id))

        }
    }
}
