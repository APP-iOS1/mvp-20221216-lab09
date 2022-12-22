//
//  CardBackView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct CardBackView: View {
    let width : CGFloat = 260
    let height : CGFloat = 410
    @Binding var degree : Double
    @State private var tag: Int? = nil
    
    
    var body: some View {
        Text("back").rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
    
}

struct CardBackView_Previews: PreviewProvider {
    static var previews: some View {
        CardBackView(degree: .constant(0))
    }
}
