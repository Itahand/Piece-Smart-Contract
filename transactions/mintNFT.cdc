import Piece from "../contracts/Piece.cdc"

transaction(creatorId: UInt64, textContent: String, recipient: Address) {


  let Administrator: &Piece.Administrator
  prepare (deployer: AuthAccount) {

    self.Administrator = deployer.borrow<&Piece.Administrator>(from: Piece.AdministratorStoragePath)
                          ?? panic("This account is not the Administrator.")
  }

  execute {
        self.Administrator.mintNFT(creatorId: creatorId, description: textContent, recipient: recipient)
  }
}