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
            CardFrontView(cardName: card.imgName, degree: $frontDegree)
            //if backDegree == 0 { //값이 0 됐을 떄 뿅! 나와서 어색해 보였던 듯?
            
            //}
        }
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
        CardFlipView(card: Card(name: "삼성 ID ON", imgName: "Samsung_iDON"))
    }
}
