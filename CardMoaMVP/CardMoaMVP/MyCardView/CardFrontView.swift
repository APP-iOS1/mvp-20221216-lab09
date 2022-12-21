//
//  CardFrontView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct CardFrontView: View {
    var cardName: String
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke()
                .foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255))
                .frame(width: 260, height: 400)


            Image("\(cardName)_L")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 260, height: 400)
                .clipped()
                .cornerRadius(15)
                .padding(.horizontal, 5)
            
            VStack {
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.white]),
                               startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
                .cornerRadius(15)
                //.border(.black)
            }
            .frame(width: 260, height: 400, alignment: .bottom)
            
            HStack {
                Text("\(cardName)")
                    .font(.title3)
                    .bold()
                    .shadow(radius: 5)
                Spacer()

                Image(systemName: "hand.tap")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.title)
                    .shadow(color:.black, radius: 3)
                

            }
            .padding(10)
            .frame(width: 260, height: 400, alignment: .bottom)
                     

        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardFrontView_Previews: PreviewProvider {
    static var previews: some View {
        CardFrontView(cardName: "Samsung_iDPET", degree: .constant(0))
    }
}
