//
//  TestCardList.swift
//  CardMoaMVP
//
//  Created by 지정훈 on 2022/12/20.
//

import SwiftUI

struct TestCardList: View {
    
    @EnvironmentObject var vm : ViewModel
    //    @StateObject var vm : ViewModel = ViewModel()
    
    var cardList = ["Hyundai", "NH", "Samsung"]
    @State var selectedCard : String = "Hyundai"
    
    
    
    var body: some View {
        VStack{
            Button {
                //                vm.test_NH()
                vm.fetchCards(cardBrand: "test_NH")
            } label: {
                Text("button")
            }
            
            
        }
    }
    
}
struct TestCardList_Previews: PreviewProvider {
    static var previews: some View {
        TestCardList().environmentObject(ViewModel())
        //        TestCardList()
    }
}

