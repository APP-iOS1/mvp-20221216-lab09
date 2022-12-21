//
//  BenefitCategoryView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/20.
//

import SwiftUI

struct BenefitCategoryView: View {
    //목록을 1부터 1000까지 만듬
    let data = Array(1...20).map { "name \($0)"}
    
    //화면을 그리드형식으로 꽉채워줌
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text("혜택 모아보기")
                    .font(.title3)
                    .padding(.leading, 20)
                    .padding(.top)
                    .fontWeight(.bold)
                Spacer()
            }
//            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) {i in
                        VStack {
                            // 카테고리 아이콘 넣을 자리 아이콘 클릭시 detail뷰로 이동
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.lightGray)
                                .frame(height: 50)
                            Text(i)
                        }
                    }
                }
                .padding(.horizontal)
//            }
        }
    }
}

struct BenefitCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitCategoryView()
    }
}
