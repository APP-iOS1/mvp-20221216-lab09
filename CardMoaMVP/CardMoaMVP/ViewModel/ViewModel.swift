import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ViewModel : ObservableObject{
    @Published var cards : [CardName] = []
    @Published var categorys : [Catergory] = []
    
    @Published var userCards : [UserCard] = []
    
    //    @Published var allFetch : [TestDic] = []
    
    let database = Firestore.firestore()
    
    
    init(){
        cards = []
        categorys = []
        //        allFetch = []
        userCards = []
    }
    
    // MARK: 회사 별 카드 종류
    func fetchCards(cardBrand: String){
        
//        var changeName : String = ""
//        switch cardBrand{
//        case "현대카드":
//            changeName = "Hyundai"
//        case "농협카드":
//            changeName = "NH"
//        case "삼성카드":
//            changeName = "Samsung"
//        default:
//            changeName = ""
//
//        }
//        print(changeName)
        //collection(cardBrand) < - (changeName)
        
        database.collection(cardBrand).getDocuments { (snapshot , error) in
            self.cards.removeAll()
    
            
            if let snapshot{
                for document in snapshot.documents{
                    var arr : [TestDic] = []
                    let id: String = document.documentID
                    
                    
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    //test_nh
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
                    
                    for i in categorys{
                        let categorys : [String:String] = i as? [String:String] ?? [:]
                        let category : String = categorys["category"] ?? ""
//                        print(i)
//                        print(type(of: i))
                        let discount : String = categorys["discount"] ?? ""
//                        let exception : String = categorys["exception"] ?? ""
                        
                        let store : [String] = categorys["store"] as? [String] ?? []
//                        print("store: \(store)")
//                        print(type(of: store))
                        print(store)
                        arr.append(TestDic(category: category, discount: discount))
                    }
                    
                    
                    let card : CardName = CardName(id: id, cardImage: cardImage, cardName: id,categorys: arr)
                    
                    self.cards.append(card)
                    
                }
            }
        }
        print(cards)
    }
    // MARK: 카드 별 혜택 정보 가져오기
    func fetchCategorys(cardBrand: String, cardName: String ){
        database.collection(cardBrand).document(cardName).collection("Category").getDocuments { (snapshot , error) in
            self.categorys.removeAll()
            if let snapshot{
                for document in snapshot.documents{
                    
                    let id: String = document.documentID
                    
                    let docData = document.data()
                    
                    let discount : String = docData["discount"] as? String ?? ""
//                    print(docData)
                    let store : Array<String> = docData["store"] as? Array<String> ?? []
//                    print("store :\(store)")
                    let exception : String = docData["exception"] as? String ?? ""
                    let category : Catergory = Catergory(id: id, discount: discount, store: store, exceptionn: exception)
                    
                    self.categorys.append(category)
                    
                }
                
            }
            
        }
        print(categorys)
    }
    func fetchUserData(){
        print("출력 완료")
        database.collection("Users").getDocuments { snapshot, error in
            self.userCards.removeAll()
            if let snapshot{
                for document in snapshot.documents{
                    
                    let id : String = document.documentID   //카드 이름
                    let docData = document.data()
                    
                    //최근 검색어
                    let currentSearch : [String] = docData["currentSearch"] as? [String] ?? []
                    let myCard : [ Any ]  = docData["myCard"] as! [Any]
                    
                    for i in myCard{
                        let myCard : [String:String] = i as! [String:String]
                        let cardImage : String = myCard["cardImage"] as? String ?? ""
                        let cardName : String = myCard["cardName"] as? String ?? ""
                        
                        //                        self.userCards.append(UserCard(cardName: cardName, cardImage: cardImage))
                        self.userCards.append(UserCard(id: UUID().uuidString, cardName: cardName, cardImage: cardImage))
                    }
                }
            }
        }
    }
    // MARK: 유저데이터에 카드, 최근 검색 저장
    func addUsersData(cardName: String, cardImage: String){
        let authId = Auth.auth().currentUser?.uid ?? ""

        
        let mycard = UsersMyCard(currentSearch: ["테스트"], myCard: [MyCard(cardName: cardName, cardImage: cardImage)])
        
        database.collection("Users").document(authId).setData(mycard as! [String : Any]){ error in
            
            if let error = error {
                print(error)
                return
            }
            print("success")
        }
    }
    
    
    // TODO: 선택된 카테고리별로 데이터베이스에서 카드 혜택이 있는지 확인 -> 후 해당 카드 이름 저장
    func searchCaregory(category : String) {
        
        var categoryKeyword : String = category
        
        switch category {
        case "외식" :
            categoryKeyword = "eatout"
        case "카페" :
            categoryKeyword = "cafe"
            
        default :
            print("카테고리 없음")
            
        }
        
        database.collection("test_NH").getDocuments { (snapshot , error) in
            if let snapshot{
                for document in snapshot.documents{
                    var arr : [TestDic] = []
                    let id: String = document.documentID
                    
                    
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    //test_nh
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
                    
                    for i in categorys{
                        let categorys : [String:String] = i as? [String:String] ?? [:]
                        let category : String = categorys["category"] ?? ""
//                        print(i)
//                        print(type(of: i))
                        let discount : String = categorys["discount"] ?? ""
//                        let exception : String = categorys["exception"] ?? ""
                        
                        let store : [String] = categorys["store"] as? [String] ?? []
//                        print("store: \(store)")
//                        print(type(of: store))
                        print(store)
                        arr.append(TestDic(category: category, discount: discount))
                    }
                    
                    
                    let card : CardName = CardName(id: id, cardImage: cardImage, cardName: id,categorys: arr)
                    
                    self.cards.append(card)
                    
                }
            }
        }

        
    }
    
    
}


//store =     (
//    starbucks,
//    "\Ud22c\Uc378\Ud50c\Ub808\Uc774\Uc2a4",
//    "\Uce74\Ud398\Ubca0\Ub124",
//    "\Ud0d0\Uc564\Ud0d0\Uc2a4",
//    "\Ucee4\Ud53c\Ube48",
//    "\Ud560\Ub9ac\Uc2a4",
//    "\Ud30c\Uc2a4\Ucfe0"
//);
