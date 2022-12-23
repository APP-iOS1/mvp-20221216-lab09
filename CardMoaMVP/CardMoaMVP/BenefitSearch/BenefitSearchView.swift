//
//  BenefitSearchView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/20.
//

import SwiftUI

struct BenefitSearchView: View {
    @State private var search = ""
    @State private var view : Int = 0
    @State var searchString : String = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    TextField("가맹점 검색하기", text: $search)
                    Button {
                        // TODO: - 검색버튼 클릭시 새 뷰로 이동, 최근 검색어에 텍스트 추가
                        // 임시용 이전 코드 가져와서 뷰와 연결한 상태
//                        searchString = search
//                        if search == "파리바게뜨" {
//                            view = 2
//                        } else {
//                            view = 1
//                        }
                    } label: {
                        Image(systemName: "magnifyingglass").foregroundColor(.black)
                    }
                }.padding().background(Color.lightGray).cornerRadius(10).padding()
                
//                검색결과가 없는 경우
                if view == 1 {
                    NoCardResultView(search: $searchString)
                        .frame(maxHeight: .infinity)
                } else if view == 2 {

                    CardResultView(search: $searchString)
                        .frame(maxHeight: .infinity)
                } else {
                    BenefitCategoryView()
                        .frame(maxHeight: .infinity)
                }
//                    BenefitCategoryView()
                    Spacer()
            }
            .navigationTitle("혜택 검색")
            // 빈 공간을 탭한 경우 키보드 내리기 - 네비게이션 타이틀 아래로는 아무곳이나 터치해도 키보드 내려감
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

struct BenefitSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitSearchView()
    }
}
