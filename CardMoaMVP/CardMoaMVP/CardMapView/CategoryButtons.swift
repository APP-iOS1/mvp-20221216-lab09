//
//  CategoryButton.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/21.
//

import SwiftUI

struct CategoryButtons: View {
    let category : [String] = ["외식", "카페", "대형마트", "편의점", "의료", "뷰티", "문화", "영화", "주유소"]
//    @Binding var selectedCategory: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach (category, id: \.self) { i in
                    Button {
                        
                    } label: {
                        Text(i)
                    }
             //        1번 방식 - background색이 캡슐 모양 밖으로도 생김.. ㅜ
//                                        .frame(width: 80, height: 45)
//                                        .foregroundColor(.black)
//                                        .background(Color.yellow)
//                                        .overlay(
//                                            Capsule().stroke(Color.mainColor, lineWidth: 3)
//                                        )
//                                        .padding(.vertical, 4)
                    
                    // 2번 방식
                    .frame(width: 80, height: 40)
                    //                    .padding(30)
                    .background(.white)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .shadow(radius: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20).stroke(Color.mainColor, lineWidth: 2)
                            .shadow(radius: 2, x: 0, y: 3)
                    )
                    .padding(.leading, 3)
                    .padding(.vertical, 6)
//                    .shadow(radius: 3)
                    // 버튼 클릭시 색 변하는 것 참고하기
//                    .foregroundColor(selectedCategory == i ? .white : .black)
//                    .tint(selectedCategory == i ? Color.accentColor : .white)
                    
                }
            }
            //                        .background(Color.yellow)
            
        }
    }
}

struct CategoryButtons_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtons()
    }
}
