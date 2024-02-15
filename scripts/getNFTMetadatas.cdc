import Piece from "../contracts/Piece.cdc"

pub fun main(_ creatorId: UInt64, _ description: String): Piece.NFTMetadata? {
  return Piece.getNFTMetadata(creatorId, description)
}