import Piece from "../contracts/Piece.cdc"

pub fun main(): {String: AnyStruct} {
  return Piece.getCollectionInfo()
}