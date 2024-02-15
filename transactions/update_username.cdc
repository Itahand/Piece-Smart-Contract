import Piece from "../contracts/Piece.cdc"

transaction(creatorId: UInt64, description: String, newUsername: String) {


  let Administrator: &Piece.Administrator
  prepare (deployer: AuthAccount) {

    self.Administrator = deployer.borrow<&Piece.Administrator>(from: Piece.AdministratorStoragePath)
                          ?? panic("This account is not the Administrator.")
  }

  execute {
        self.Administrator.updateUsername(creatorId: creatorId, description: description, newUsername: newUsername)
  }
}