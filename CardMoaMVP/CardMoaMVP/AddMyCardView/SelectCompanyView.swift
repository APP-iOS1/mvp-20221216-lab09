//
//  SelectCompanyView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct SelectCompanyView: View {
    let data = Array(1...15).map { "name \($0)"}
    
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
                    ForEach(data, id: \.self) {i in
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.lightGray)
                                .frame(width: 80, height: 80)
                            Text(i)
                        }
                    }
                }
                .padding()
            }
        }
    }
}


struct SelectCompanyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCompanyView()
    }
}
