import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ViewModel : ObservableObject{
    @Published var cards : [CardName] = []
    @Published var categorys : [Category] = []
    @Published var userCards : [UserCard] = []
    @Published var brandCategory  = [[]]
    
    
    
    let database = Firestore.firestore()
    
    init(){
        cards = []
        categorys = []
        userCards = []
        brandCategory = []
    }
    // MARK: 회사 별 카드 종류
    func fetchCards(cardBrand: String){
        database.collection(cardBrand).getDocuments { (snapshot , error) in
            self.cards.removeAll()
            
            
            if let snapshot{
                for document in snapshot.documents{
                    var temp : [Category] = []
                    let id: String = document.documentID
                    //                    print(id)
                    
                    let docData = document.data()
                    print(docData)
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
                    //                    print(cardImage)
                    
                    for i in categorys{
                        
                        let categorys : [String:Any] = i as? [String:Any] ?? [:]
                        let category : String = categorys["category"] as! String
                        let discount : String = categorys["discount"] as? String ?? ""
                        let store : [String] = categorys["store"] as? [String] ?? []
                        let exception : String = categorys["exception"] as? String ?? ""
                        //                        print(category)
                        //                        print(discount)
                        //                        print(store)
                        let arrCategory = Category(id: category, discount: discount, store: store, exception: exception,category: category)
                        temp.append(arrCategory)
                    }
                    let card : CardName = CardName(id: id, cardImage: cardImage, cardName: id, categorys: temp )
                    
                    self.cards.append(card)
                    
                }
            }
        }
        //        print("\(cards) \n")
    }
    // MARK: 카드 별 혜택 정보 가져오기
    //    func fetchCategorys(cardBrand: String, cardName: String ){
    //        database.collection(cardBrand).document(cardName).collection("Category").getDocuments { (snapshot , error) in
    //            self.categorys.removeAll()
    //            if let snapshot{
    //                for document in snapshot.documents{
    //
    //                    let id: String = document.documentID
    //
    //                    let docData = document.data()
    //
    //                    let discount : String = docData["discount"] as? String ?? ""
    //                    //                    print(docData)
    //                    let store : Array<String> = docData["store"] as? Array<String> ?? []
    //                    //                    print("store :\(store)")
    //                    let exception : String = docData["exception"] as? String ?? ""
    //                    let category : Catergory = Catergory(id: id, discount: discount, store: store, exceptionn: exception)
    //
    //                    self.categorys.append(category)
    //
    //                }
    //
    //            }
    //
    //        }
    //        print(categorys)
    //    }
    // 현재 파이어베이스에 저장되어 있는 유저의 카드 목록을 보여줍니다 ( 카드 이름, 카드 이미지 )까지만
    func fetchUserData(){
        database.collection("Users").getDocuments { snapshot, error in
            self.userCards.removeAll()
            if let snapshot{
                for document in snapshot.documents{
                    
                    let id : String = document.documentID   //카드 이름
                    let docData = document.data()
                    
                    //최근 검색어
                    let currentSearch : [String] = docData["currentSearch"] as? [String] ?? []
                    let myCard : [ Any ]  = docData["myCard"] as? [Any] ?? []
                    
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
        database.collection("Users").document(authId).updateData(
             [ "currentSearch" : FieldValue.arrayUnion([""]) ,
                  "mycard" : FieldValue.arrayUnion ([
                    [
                        "cardImage" : cardImage,
                        "cardName" : cardName
                    ]
                  ])
                ]
        
        )
        
    }
    // MARK: 유저 카드데이터 구조 생성
    // TODO: 어떻게 하면 한번만 실행 할지
    func onApearUserData(oneTime: Bool){
        if oneTime{
            let authId = Auth.auth().currentUser?.uid ?? ""
            database.collection("Users").document(authId).setData(
                 [ "currentSearch" : [""] ,
                      "mycard" : [
                        [
                            "cardImage" : "",
                            "cardName" : ""
                        ]
                      ]
                    ]
            
            )
        }
        
    }
    
    // MARK: 카드 별 혜택 카테고리 가져오기
    func fetchBenefitCategorys(cardBrand: String){
        database.collection(cardBrand).getDocuments { snapshot, error in
            self.brandCategory.removeAll()
            if let snapshot{
                for document in snapshot.documents{
                    var temp : [String] = []
                    
                    let id: String = document.documentID
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
                    print(id)
                    //                    self.brandCategory.append(BrandCategory(categoryArr: temp))
                    //                    temp.removeAll()
                    //                    print(temp)
                    for i in categorys{
                        let categorys : [String:Any] = i as? [String:Any] ?? [:]
                        let category : String = categorys["category"] as! String
                        let discount : String = categorys["discount"] as? String ?? ""
                        let store : [String] = categorys["store"] as? [String] ?? []
                        print(category)
                        print(discount)
                        print(store)
                        
                    }
                    //                    self.brandCategory.append(temp)
                    
                }
            }
        }
        //        print("brandCategory: \(brandCategory)")
    }
}
