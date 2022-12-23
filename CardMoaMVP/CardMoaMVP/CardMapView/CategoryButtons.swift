//
//  CategoryButton.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/21.
//

import SwiftUI

struct CategoryButtons: View {
    let category : [String] = ["카페", "외식", "대형마트", "편의점", "의료", "뷰티", "문화", "영화", "주유소"]
    @Binding var selectedCategoryButton: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach (category.indices, id: \.self) { i in
                    Button {
                        selectedCategoryButton = i
                    } label: {
                        Text(category[i])
                    }
//                    .frame(width: 80, height: 40)
                    .frame(height: 40)
                    .padding(.horizontal)
                    // 버튼 클릭시 색 변하는 것 참고하기
                    .foregroundColor(selectedCategoryButton == i ? .white : .black)
                    .background(selectedCategoryButton == i ? Color.mainColor : .white)
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color.mainColor, lineWidth: 2)
                            .shadow(radius: 2, x: 0, y: 3)
                    )
                    .padding(.leading, 3)
                    .padding(.vertical, 6)
//                    .shadow(radius: 3)
                }
            }
            //                        .background(Color.yellow)
            
        }
    }
}

struct CategoryButtons_Previews: PreviewProvider {
    @State static var selectedCategoryButton: Int = 0
    static var previews: some View {
        CategoryButtons(selectedCategoryButton: $selectedCategoryButton)
    }
}
