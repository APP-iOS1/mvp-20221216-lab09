//
//  AddCardListView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct AddCardListView: View {
    @State var listX: CGFloat = 0
    var card: CardName
    
    @EnvironmentObject var vm : ViewModel
    
    @State private var showingAlert: Bool = false
    @State private var arrow: String = "<<"
    @State private var symbolImage : String = ""
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
                        
                        Text(arrow)
                            .padding(3)
                            .foregroundColor(.gray)
                            .bold()
                            
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
                        Text("\(card.cardName)")
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .font(.title2)
                    .bold()

                    HStack {
                        AsyncImage(url:URL(string:  card.cardImage)){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.clear
                        }
                        .frame(height: 100)

                        VStack(alignment: .leading) {
                            ForEach(Array(card.categorys.enumerated()), id: \.offset ){ index , object in
                                if index < 4 {
                                    HStack {
                                        switch card.categorys[index].category{
                                        case "cafe":
                                            Image(systemName: "cup.and.saucer.fill")
                                            Text("카페/베이커리")
                                        case "mart":
                                            Image(systemName: "bag.fill")
                                            Text("마트")
                                        case "telephone":
                                            Image(systemName: "phone.fill")
                                            Text("통신")
                                        case "medical":
                                            Image(systemName: "cross.case.fill")
                                            Text("의료")
                                        case "leisure":
                                            Image(systemName: "figure.disc.sports")
                                            Text("레저")
                                        case "shopping":
                                            Image(systemName: "cart.fill")
                                            Text("쇼핑")
                                        case "cinema":
                                            Image(systemName: "popcorn.fill")
                                            Text("영화관")
                                        default:
                                            Image(systemName: "star.fill")
                                        }
                                        
                                    }
                                }
                              
                            }
//                            HStack {
//                                Image(systemName: "ticket")
//                                Text("\(card.categorys[0].category)")
//                            }
//                            HStack {
//                                Image(systemName: "fork.knife")
//                                    .padding(.leading, 2)
//                                Text("외식 & 베이커리")
//                                    .padding(.leading, 4)
//                            }
//                            HStack {
//                                Image(systemName: "bus")
//                                Text("교통")
//                            }
//                            HStack {
//                                Image(systemName: "cart.fill")
//                                Text("쇼핑")
//                            }
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
                        if listX <= 0 && listX >= -90 { //-90보다 크고 0보다 작을 때
                            listX += value.translation.width / 30
                            if listX <= -90 { // -90보다 작거나 같을 때
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


struct AddCardListView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardListView(card: CardName(id: " ", cardImage: " ", cardName: " ", categorys:[]) ).environmentObject(ViewModel())
    }
}
