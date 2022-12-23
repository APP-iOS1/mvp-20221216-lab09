import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ViewModel : ObservableObject{
    @Published var cards : [CardName] = []
    @Published var categorys : [Category] = []
    @Published var userCards : [UserCard] = []
    @Published var brandCategory  = [[]]
    @Published var usersCurrentSearch :[String] = []
    
    
    let database = Firestore.firestore()
    
    init(){
        cards = []
        categorys = []
        userCards = []
        brandCategory = []
        usersCurrentSearch = []
    }
    // MARK: 회사 별 카드 종류
    func fetchCards(cardBrand: String){
        database.collection(cardBrand).getDocuments { (snapshot , error) in
            self.cards.removeAll()
            
            
            if let snapshot{
                for document in snapshot.documents{
                    var temp : [Category] = []
                    let id: String = document.documentID
   
                    
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
              
                    
                    for i in categorys{
                        
                        let categorys : [String:Any] = i as? [String:Any] ?? [:]
                        let category : String = categorys["category"] as! String
                        let discount : String = categorys["discount"] as? String ?? ""
                        let store : [String] = categorys["store"] as? [String] ?? []
                        let exception : String = categorys["exception"] as? String ?? ""
       
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
    
    // MARK: 나의 카드 페이지에서 Users DB안에 있는 개인의 카드 목록 보여주기
    func fetchUsersCardData(){
        let authId = Auth.auth().currentUser?.uid ?? ""
        database.collection("Users").document(authId).getDocument { snapshot, error in
            if let snapshot{
                let docData = snapshot.data()
                let myCard : [Any] = docData?["myCard"] as! [Any]
                for i in myCard{
                    let categorys : [String:Any] = i as? [String:Any] ?? [:]
                    let cardName : String = categorys["cardName"] as? String ?? ""
                    let cardImage : String = categorys["cardImage"] as? String ?? ""
            
                    self.userCards.append(UserCard(id: UUID().uuidString, cardName: cardName, cardImage: cardImage))
                }
            }
        }
    }
    
    // MARK: 유저 데이터의 최근 검색어 불러오기
    func fetchUsersCurrentSearch(){
        let authId = Auth.auth().currentUser?.uid ?? ""
        database.collection("Users").document(authId).getDocument { snapshot, error in
            self.usersCurrentSearch.removeAll()
            if let snapshot{
                let docData = snapshot.data()
                let currentSearch : [ String ]  = docData?["currentSearch"] as? [String] ?? []
                self.usersCurrentSearch = currentSearch
//                 검색 시 최근검색어 쌓아주기(최대 5개, 이상 추가 시 오래된 검색어 삭제) #30
                if self.usersCurrentSearch.count > 5{
                    // 배열에서 지움
                    self.usersCurrentSearch.removeFirst()
                    // DB에서 지움
                    self.removeUsersCurrentSearch()
                }
            }
        }
        
    }
    
    // MARK: usersCurrentSearch 갯수가 5개 넘어가면 메서드 호출 usersCurrentSearch의 첫번째 요소 지움
    func removeUsersCurrentSearch(){
        let authId = Auth.auth().currentUser?.uid ?? ""
        database.collection("Users").document(authId).getDocument { snapshot, error in
            if let snapshot{
                let docData = snapshot.data()
                let currentSearch : [ String ]  = docData?["currentSearch"] as? [String] ?? []
                self.database.collection("Users").document(authId).updateData([
                    "currentSearch": FieldValue.arrayRemove([currentSearch[0]])
                ])
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
    func onApearUserData(){
        
        if true{
            let authId = Auth.auth().currentUser?.uid ?? ""
            database.collection("Users").document(authId).setData(
                [ "currentSearch" : [""] ,
                  "myCard" : [
                    [
                        "cardImage" : "https://vertical.pstatic.net/vertical-cardad/creatives/NH/10186/NH_10186_20221018-105717_ver.png",
                        "cardName" : "zgmStreaming"
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
                    
                    for i in categorys{
                        let categorys : [String:Any] = i as? [String:Any] ?? [:]
                        let category : String = categorys["category"] as! String
                        let discount : String = categorys["discount"] as? String ?? ""
                        let store : [String] = categorys["store"] as? [String] ?? []
                        
                        
                    }
                }
            }
        }
     
    }
}
