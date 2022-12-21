import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ViewModel : ObservableObject{
    @Published var cards : [CardName] = []
    @Published var categorys : [Catergory] = []
    @Published var allFetch : [Catergory] = []
    let database = Firestore.firestore()
    
    
    init(){
        cards = []
        categorys = []
        allFetch = []
    }
    
    // MARK: 회사 별 카드 종류
    func fetchCards(cardBrand: String){
        database.collection(cardBrand).getDocuments { (snapshot , error) in
            self.cards.removeAll()
            if let snapshot{
                for document in snapshot.documents{
                    
                    let id: String = document.documentID
                    
                    
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    let card : CardName = CardName(id: id, cardImage: cardImage, cardName: id)

                    self.cards.append(card)
                    
                }
                
            }
            
        }
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
                    let store : Array<String> = docData["store"] as? Array<String> ?? []
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

}

