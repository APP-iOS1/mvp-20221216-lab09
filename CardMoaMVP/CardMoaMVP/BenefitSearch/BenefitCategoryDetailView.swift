//
//  BenefitCategoryDetailView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/20.
//

import SwiftUI
// TODO: - db에서 받아서 텍스트 불러와야하는 곳이라 프레임만 만듦 !

struct BenefitCategoryDetailView: View {
    @State var categoryName : String
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        VStack {
            //            HStack{
            //                Text("카테고리명")
            //                    .font(.largeTitle)
            //                    .padding(.leading, 20)
            //                    .padding(.top)
            //                    .fontWeight(.bold)
            //                Spacer()
            //            }
            ScrollView {
                //Foreach 넣기
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .padding()
                        
                        Text("카드명")
                            .font(.title3)
                        //Text(Card.cardList[0].name)
                            .bold()
                    }
                    .frame(width: 370, height: 70,alignment: .leading)
                    
                    Text("혜택내용")
                        .padding(.leading, 20)
                    
                    
                }
                .frame(width: 330)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .padding(5)
                .shadow(radius: 7, x: 0, y: 5)
            }
            // FIXME: #29
            .navigationTitle(categoryName) //#29 카테고리 선택 시 데이터 연동 - navigationTitle 혜택이름 넣기 (feat.LJA)
        }.onAppear{
            print("여기 : \(categoryName)")
            vm.searchCaregory(category: categoryName) //#29 카테고리 선택 시 데이터 연동 - 여기서 카테고리별 카드가 있는지 없는지 확인하는 함수 불러옴 (feat.LJA)
        }
    }
}

struct BenefitCategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitCategoryDetailView(categoryName: "카테고리네임").environmentObject(ViewModel())
    }
}
