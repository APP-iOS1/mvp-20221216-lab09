//
//  ViewModel.swift
//  CardMoaMVP
//
//  Created by 지정훈 on 2022/12/20.
//

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
        
        var changeName : String = ""
        switch cardBrand{
        case "현대카드":
            changeName = "Hyundai"
        case "농렵카드":
            changeName = "NH"
        case "삼성카드":
            changeName = "Samsung"
        default:
            changeName = ""
            
        }
        
        //collection(cardBrand) < - (changeName) 바꾸기
        database.collection("test_NH").getDocuments { (snapshot , error) in
            self.cards.removeAll()
            print(changeName)
            if let snapshot{
                for document in snapshot.documents{
                    var arr : [TestDic] = []
                    let id: String = document.documentID
                    
                    
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    
                    //test_nh
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
                    
                    for i in categorys{
                        let categorys : [String:String] = i as! [String:String]
                        let category : String = categorys["category"] as? String ?? ""
                        let discount : String = categorys["discount"] as? String ?? ""
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
    func test_NH(){
        database.collection("test_NH").getDocuments { snapshot, error in
            if let snapshot{
                for document in snapshot.documents{
                    
                    let id : String = document.documentID   //카드 이름
                    let docData = document.data()
                    
                    let cardImage : String = docData["cardImage"] as? String ?? ""
                    let categorys : [ Any ]  = docData["categorys"] as! [Any]
                    
                    for i in categorys{
                        let categorys : [String:String] = i as! [String:String]
                        let category : String = categorys["category"] as? String ?? ""
                        let discount : String = categorys["discount"] as? String ?? ""
                        
                        //                            self.allFetch.append(testDic(category: category, discount: discount))
                        
                    }
                }
            }
        }
        
//        print(allFetch)
    }
}

