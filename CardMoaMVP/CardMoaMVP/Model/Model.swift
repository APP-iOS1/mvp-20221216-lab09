import Foundation


struct CardName :Identifiable,Hashable{
    var id: String
    var cardImage: String
    var cardName: String
}

struct Catergory :Identifiable,Hashable {
    var id : String             //airport , cafe , csv, cinema 등등
    var discount: String
    var store: [String]
    var exceptionn: String
}


