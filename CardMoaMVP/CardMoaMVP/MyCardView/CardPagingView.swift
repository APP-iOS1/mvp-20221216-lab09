//
//  CardPagingView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI
import CollectionViewPagingLayout

struct CardPagingView: View {

    @EnvironmentObject var vm : ViewModel

    var options: ScaleTransformViewOptions {
        .layout(.linear)
    }
    
    var body: some View {

        ScalePageView(vm.userCards) { card in

            CardFlipView(card: card)
        }
        .options(options)
        .pagePadding(
            vertical: .absolute(100),
            horizontal: .absolute(80)
        )
        .frame(height: 500)
    }
}

struct CardPagingView_Previews: PreviewProvider {
    static var previews: some View {
        CardPagingView()
    }
}
