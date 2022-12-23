//
//  NoCardResultView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/21.
//

import SwiftUI

struct NoCardResultView: View {
    @Environment(\.presentationMode) var presentable
    @Binding var search : String
    
    var body: some View {
        NavigationStack{
            VStack{
                // TODO: - 뒤로가기 버튼 추가하기, 어느 위치에 할건지..?
                // 새로 뷰 만들어서 (회원가입처럼) 툴바에 뒤로가기 버튼
                // flag사용하는 방법도 찾아봐
                
                Image("cards").resizable().frame(width: 150, height: 150)
                Text("\(search)").foregroundColor(.mainColor) + Text(" 결제에")
                Text("혜택이 있는 나의 카드가 없어요")
            }
            .fontWeight(.bold).font(.system(size: 20))
        }
    }
}

struct NoCardResultView_Previews: PreviewProvider {
    static var previews: some View {
        NoCardResultView(search: .constant("파리바게뜨"))
    }
}
