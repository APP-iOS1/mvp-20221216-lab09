import Foundation


struct CardName :Identifiable,Hashable{
    var id: String
    var cardImage: String
    var cardName: String
    var categorys : [TestDic]
}

struct Catergory :Identifiable,Hashable {
    var id : String             //airport , cafe , csv, cinema 등등
    var discount: String
    var store: [String]
    var exceptionn: String
}


//임시
//struct testCategory :Identifiable,Hashable{
//    var id: String
//    var categorys :
//}
struct TestDic :Hashable{
    var category: String
    var discount: String
}
// 메인페이지 유저 카드 보여줌
struct UserCard:Identifiable,Hashable{
    var id : String
    var cardName : String
    var cardImage : String
}
