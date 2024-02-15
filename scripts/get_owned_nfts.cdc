import Piece from "../contracts/Piece.cdc"
import MetadataViews from "../contracts/standard/MetadataViews.cdc"

pub fun main(address: Address): [AnyStruct] {
  let collection = getAccount(address).getCapability(Piece.CollectionPublicPath)
                      .borrow<&Piece.Collection{MetadataViews.ResolverCollection}>()!
  let answer: [AnyStruct]  = []
  var nft: AnyStruct = nil
  var counter: UInt64 = 0

  let ids = collection.getIDs()

  for id in ids {

    let resolver = collection.borrowViewResolver(id: id)
    let displayView = resolver.resolveView(Type<MetadataViews.Display>())! as! MetadataViews.Display
    let serialView = resolver.resolveView(Type<MetadataViews.Serial>())! as! MetadataViews.Serial
    let traitsView = resolver.resolveView(Type<MetadataViews.Traits>())! as! MetadataViews.Traits

    counter = counter + 1

    nft = {
      "nftId": id,
      "serial": serialView,
      "traits": traitsView,
      "display": displayView
      }

    answer.append(nft)
  } 

  answer.append(counter)
  return answer
}