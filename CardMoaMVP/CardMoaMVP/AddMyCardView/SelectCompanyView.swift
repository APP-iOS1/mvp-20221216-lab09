//
//  SelectCompanyView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct SelectCompanyView: View {
    let data = Array(1...15).map { "name \($0)"}
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
    
    var body: some View {
        VStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<12) {i in
                        Button {
                            currentCompanyStore.companyName = names[i]
                            showingSheet.toggle()
                        } label: {
                            VStack {
                                Image(logos[i])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 35)
                                Text(names[i])
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 40)
                    }
                }
                .padding()
            }
        }
    }
}


struct SelectCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompanyView(showingSheet: .constant(true), currentCompanyStore: CurrentCompanyStore())
    }
}
