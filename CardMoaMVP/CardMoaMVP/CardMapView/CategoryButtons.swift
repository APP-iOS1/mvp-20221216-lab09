//
//  CategoryButton.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/21.
//

import SwiftUI

struct CategoryButtons: View {
    
    let category : [String] = ["외식", "카페", "대형마트", "편의점", "의료", "뷰티", "문화", "영화", "주유소"]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach (category, id: \.self) { i in
                    Button {
                        
                    } label: {
                        Text(i)
                    }.frame(width: 80, height: 45)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.mainColor, lineWidth: 3)
                                
                        )
                        .padding(2)
             
                }
            }
            
        }
    }
}

struct CategoryButtons_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtons()
    }
}
