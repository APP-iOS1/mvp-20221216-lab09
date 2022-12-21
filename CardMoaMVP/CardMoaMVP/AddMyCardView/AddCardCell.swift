//
//  AddCardListView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct AddCardCell: View {
    @State var listX: CGFloat = 0
    var card: Card
    @State private var showingAlert: Bool = false
    @State private var arrow: String = "<<"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                .frame(width: UIScreen.main.bounds.width - 30, height: 170)
                .shadow(radius: 5, y: 3)
                .overlay(
                    HStack() {
                        Spacer()
                        VStack {
                            Image(systemName: "plus.circle")
                            Text("나의 카드 \n등록")
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                        .padding(.trailing, 20)
                        
                        Image(systemName: "chevron.left.2")
                            .padding(3)
                            .foregroundColor(.mainColor)
                            //.bold()
                            
                    }
                )
            
            
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 170)
                    .shadow(radius: 5, x: 4, y: 3)
                    .offset(x: -15)
                    

                VStack {
                    HStack {
                        Text("\(card.name)")
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .font(.title3)
                    .bold()

                    HStack {
                        Image("\(card.imgName)_B")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)

                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "ticket")
                                Text("연회비 지원")
                            }
                            HStack {
                                Image(systemName: "fork.knife")
                                    .padding(.leading, 2)
                                Text("외식 & 베이커리")
                                    .padding(.leading, 4)
                            }
                            HStack {
                                Image(systemName: "bus")
                                Text("교통")
                            }
                            HStack {
                                Image(systemName: "cart.fill")
                                Text("쇼핑")
                            }
                        }
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .foregroundColor(.gray)
                        )
                        .foregroundColor(.gray)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 60, height: 170)
                .offset(x: -15)

            } // ZStack2
            .offset(x: listX)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if listX <= 0 && listX >= -20 { //-90보다 크고 0보다 작을 때
                            listX += value.translation.width / 30
                            if listX <= -20 { // -90보다 작거나 같을 때
                                showingAlert = true
                               
                            }
                        }
                        arrow = ""
                        
                    }
                    .onEnded { value in
                        listX = 0
                        arrow = "<<"
                    }
            )
            .alert("카드를 추가하시겠습니까?", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) {
                    listX = 0
                    arrow = "<<"
                }
                Button("OK") {
                    listX = 0
                    arrow = "<<"
                }
                
            }
        }
        
    } // ZStack1
}

//
//struct AddCardCell_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCardCell(card: CardName(id: " ", cardImage: " ", cardName: " ", categorys:[]) ).environmentObject(ViewModel())
//
//    }
//}
