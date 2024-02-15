import Piece from "../contracts/Piece.cdc"

pub fun main(creatorId: UInt64, textContent: String): Bool {

    let answer: Bool = Piece.isMintingAvailable(creatorId, textContent)

  return answer 
}