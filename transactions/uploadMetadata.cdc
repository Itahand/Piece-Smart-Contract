import Piece from "../contracts/Piece.cdc"

  transaction(
    _channel: String,
    _creatorId: UInt64,
    _creatorUsername: String,
    _creatorAddress: Address,
    _sourceURL: String,
    _textContent: String,
    _pieceCreationDate: String,
    _contentCreationDate: String,
    _lockdownOption: Int,
    _supplyOption: UInt64,
    _imgUrl: String,
    _embededHTML: String,
  ) {
    let Administrator: &Piece.Administrator
    prepare(deployer: AuthAccount) {
      self.Administrator = deployer.borrow<&Piece.Administrator>(from: Piece.AdministratorStoragePath)
                           ?? panic("This account is not the Administrator.")
   }

    execute {
        self.Administrator.createNFTMetadata(
          channel: _channel,
    			creatorID: _creatorId,
          creatorUsername: _creatorUsername,
    			creatorAddress: _creatorAddress,
    			sourceURL: _sourceURL,
    			description: _textContent,
    			pieceCreationDate: _pieceCreationDate,
    			contentCreationDate: _contentCreationDate,
          lockdownOption: _lockdownOption,
          supplyOption: _supplyOption,
    			imgUrl: _imgUrl,
    			embededHTML: _embededHTML,
        )
    }
  }