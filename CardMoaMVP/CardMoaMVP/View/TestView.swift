//
//  TestView.swift
//  CardMoaMVP
//
//  Created by 지정훈 on 2022/12/20.
//

import SwiftUI

struct TestView: View {
    @StateObject var vm : ViewModel = ViewModel()
    @EnvironmentObject var authModel : AuthViewModel
    
    // 나중에 카드 선택
    @State var cardBrand : String = "NH"
    @State var cardName : String = "쏠쏠(SolSol)"
    var body: some View {
        NavigationStack{
            VStack{
                Button {
    //                vm.fetchCards(cardBrand:cardBrand)
                } label: {
                    Text("버튼")
                }
                Text(authModel.loginedUserName ?? "")
                
                NavigationLink {
                    TestCardList()
                } label: {
                    Text("Plus")
                }

                
                Button {
                    authModel.logout()
                } label: {
                    Text("로그아웃")
                }
                
                
            }
        }
      
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView().environmentObject(AuthViewModel())
    }
}



