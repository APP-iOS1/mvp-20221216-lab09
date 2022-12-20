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
    

    
    let database = Firestore.firestore()
    
    
    init(){
        cards = []
        categorys = []
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
//                print(self.cards)
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
                print(self.categorys)
            }
            
        }
 
    }
    
    
    
    
}

