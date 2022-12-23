//
//  CardFlipView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct CardFlipView: View {
    var card : UserCard
    
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    
    let durationAndDelay : CGFloat = 0.3
    @EnvironmentObject var vm : ViewModel
    var body: some View {
        ZStack {
            CardBackView(degree: $backDegree)
            CardFrontView(card: card, degree: $frontDegree)
        }
        .frame(width: 220, height: 347)
        .onTapGesture {
            flipCard ()
        }
    }
    
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    } // flipCard
    
}

struct CardFlipView_Previews: PreviewProvider {
    static var previews: some View {
        CardFlipView(card:UserCard(id: "", cardName: "taptapO", cardImage: "https://vertical.pstatic.net/vertical-cardad/creatives/SS/1530/SS_1530_hor.png"))
    }
}
