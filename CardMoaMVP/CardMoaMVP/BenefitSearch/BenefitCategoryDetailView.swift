//
//  BenefitCategoryDetailView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/20.
//

import SwiftUI
// TODO: - db에서 받아서 텍스트 불러와야하는 곳이라 프레임만 만듦 !

struct BenefitCategoryDetailView: View {
    var body: some View {
        VStack {
            HStack{
                Text("카테고리명")
                    .font(.largeTitle)
                    .padding(.leading, 20)
                    .padding(.top)
                    .fontWeight(.bold)
                Spacer()
            }
            
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
                .background(Color.lightGray)
                .cornerRadius(20)
                .padding(5)
//                .shadow(radius: 1)
            }
        }
    }
}

struct BenefitCategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitCategoryDetailView()
    }
}
