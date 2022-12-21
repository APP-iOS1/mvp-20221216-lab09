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

struct TestDic :Hashable{
    var category: String
    var discount: String
    
    var exception : String?
    var store : [String?]?
    
}
// 메인페이지 유저 카드 보여줌
struct UserCard:Identifiable,Hashable{
    var id : String?
    var cardName : String?
    var cardImage : String?
}


// 유저 데이터 저장
struct MyCard: Hashable{
    var cardName : String
    var cardImage : String
}
struct UsersMyCard{
    var currentSearch : [String]
    var myCard : [MyCard]
}



//기록
