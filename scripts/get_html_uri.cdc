import Piece from "../contracts/Piece.cdc"
import MetadataViews from "../contracts/standard/MetadataViews.cdc"

pub fun main(Account: Address): [MetadataViews.Medias] {
  let collection = getAccount(Account).getCapability(Piece.CollectionPublicPath)
                      .borrow<&Piece.Collection{MetadataViews.ResolverCollection}>()!
  let answer: [MetadataViews.Medias] = []

  let ids = collection.getIDs()

  for id in ids {
    let resolver = collection.borrowViewResolver(id: id)
    let mediasView = resolver.resolveView(Type<MetadataViews.Medias>())! as! MetadataViews.Medias
    answer.append(mediasView)
  }

  return answer 
}
