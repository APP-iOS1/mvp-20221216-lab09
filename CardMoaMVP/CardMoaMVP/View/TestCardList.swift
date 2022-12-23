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
//                vm.fetchCategorys(cardBrand: "Hyundai", cardName: "inflca")
            } label: {
                Text("button")
            }
            
            
            HStack{
                // 카드 브랜드 선택
                Picker("카드선택", selection: $selectedCard) {
                    ForEach(cardList, id: \.self){
                        Text($0)
                    }
                }
            }
            // 카드가 보여줄 부분
            ForEach(vm.cards){ index in
                Text(index.id)
            }
            
        }.onAppear{
            vm.fetchCards(cardBrand: selectedCard)
        }
        .onChange(of: selectedCard) { newValue in           //newValue 모르겠음
            vm.fetchCards(cardBrand: selectedCard)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                for i in vm.cards{
//                    vm.fetchCategorys(cardBrand: selectedCard, cardName: i.cardName)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        print(vm.categorys)
                    }
                    
                }
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
