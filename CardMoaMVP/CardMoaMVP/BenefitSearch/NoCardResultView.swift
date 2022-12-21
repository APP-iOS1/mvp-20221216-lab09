//
//  NoCardResultView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/21.
//

import SwiftUI

struct NoCardResultView: View {
    @Binding var search : String
    
    var body: some View {
        NavigationStack{
            VStack{
                // TODO: - 뒤로가기 버튼 추가하기, 어느 위치에 할건지..?
                // 새로 뷰 만들어서 (회원가입처럼) 툴바에 뒤로가기 버튼
                // flag사용하는 방법도 찾아봐
//                HStack{
//                    //                Image(systemName: "chevron.backward")
//                    TextField("검색어를 입력해주세요", text: $search)
//                    Button {
//                        // TODO: - 검색버튼클릭시 새 뷰로 이동, 최근 검색어에 텍스트 추가
//                        // 버튼 클릭시
//                    } label: {
//                        Image(systemName: "magnifyingglass").foregroundColor(.black)
//                    }
//                }.padding().background(Color.lightGray).cornerRadius(10).padding()
                
                Image("cards").resizable().frame(width: 150, height: 150)
                Text("\(search)").foregroundColor(.mainColor) + Text(" 결제에")
                Text("혜택이 있는 나의 카드가 없어요")
            }
            .fontWeight(.bold).font(.system(size: 20))
//            .toolbar{
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
////                        dismiss()
//                    } label: {
//                        HStack {
//                            Image(systemName: "chevron.backward")
//                                .bold()
//                            Text("돌아가기")
//                        }
//                    }
//                }
//            }
        }
    }
}

struct NoCardResultView_Previews: PreviewProvider {
    static var previews: some View {
        NoCardResultView(search: .constant("파리바게뜨"))
    }
}
