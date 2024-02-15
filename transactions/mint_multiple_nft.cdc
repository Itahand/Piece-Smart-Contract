import Piece from "../contracts/Piece.cdc"

transaction(creatorId: UInt64, textContent: String, recipients: [Address]) {


  let Administrator: &Piece.Administrator
  prepare (deployer: AuthAccount) {

    self.Administrator = deployer.borrow<&Piece.Administrator>(from: Piece.AdministratorStoragePath)
                          ?? panic("This account is not the Administrator.")
  }

  execute {

    var i = 0
    while i < recipients.length {
        self.Administrator.mintNFT(creatorId: creatorId, description: textContent, recipient: recipients[i])
        i = 1 + i
    }
  }
}