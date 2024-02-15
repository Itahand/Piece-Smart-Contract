import Piece from "../contracts/Piece.cdc"

transaction(creatorIds: [UInt64], textContents: [String], recipients: [Address]) {


  let Administrator: &Piece.Administrator
  prepare (deployer: AuthAccount) {

    self.Administrator = deployer.borrow<&Piece.Administrator>(from: Piece.AdministratorStoragePath)
                          ?? panic("This account is not the Administrator.")
  }

  pre {
    creatorIds.length == textContents.length: "CreatorIds not same length as TextContents"
    creatorIds.length == recipients.length: "CreatorIds not same length as Recipients"
    recipients.length == textContents.length: "Recipients not same length as TextContents"
  }

  execute {
    var i = 0
    while i < recipients.length {
        self.Administrator.mintNFT(creatorId: creatorIds[i], description: textContents[i], recipient: recipients[i])
        i = 1 + i
    }
  }
}