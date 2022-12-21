//
//  SelectCompanyView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct SelectCompanyView: View {
    let data = Array(1...15).map { "name \($0)"}
    
    let cardCompany = ["현대카드" , "농협카드" ,"삼성카드" ,"신한카드", "카카오카드"]
    
    @State var currentCompany: String = "삼성카드"
    @Binding var showingSheet: Bool
    var currentCompanyStore: CurrentCompanyStore
    
    
    //화면을 그리드형식으로 꽉채워줌
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cardCompany, id: \.self) {i in
                        
                        Button {
                            //                            vm.fetchCards(cardBrand: i) //나중에 바꾸면 됨
                            vm.fetchCards(cardBrand: "test_NH")
                        } label: {
                            VStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.lightGray)
                                    .frame(width: 80, height: 80)
                                Text(i)
                            }
                            
                        }
                        
                        
                        //                    ForEach(company, id: \.self) {i in
                        //                        Button {
                        //                            currentCompanyStore.companyName = i
                        //                            showingSheet.toggle()
                        //                        } label: {
                        //                            VStack {
                        //                                Image(i)
                        //                                    .resizable()
                        //                                    .scaledToFit()
                        //                                    .frame(height: 35)
                        //                                Text(i)
                        //                                    .font(.footnote)
                        //                                    .bold()
                        //                                    .foregroundColor(.black)
                        //                            }
                        //                        }
                        //                        .padding(.top, 40)
                    }
                }
            }
            .padding()
        }
    }
}



struct SelectCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompanyView(showingSheet: .constant(true), currentCompanyStore: CurrentCompanyStore()).environmentObject(ViewModel())
    }
}
