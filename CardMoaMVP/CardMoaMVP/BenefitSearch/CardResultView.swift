//
//  CardResultView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/21.
//

import SwiftUI

struct CardResultView: View {
    @Binding var search : String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text("\(search)").foregroundColor(.mainColor)
                Text("결제 혜택이 있는 나의 카드")
            }.font(.title2).fontWeight(.bold)
                .padding(.leading, -120)
                .padding(.bottom, 20)
            
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
    }
}

struct CardResultView_Previews: PreviewProvider {
    static var previews: some View {
        CardResultView(search: .constant("파리바게뜨"))
    }
}


/*
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
 */
