//
//  AddCardListView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI
struct AddCardCell: View {
    @State var listX: CGFloat = 0
    var card: CardName
    @EnvironmentObject var vm : ViewModel
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
                        Text("\(card.cardName)")
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .font(.title3)
                    .bold()
                
                    HStack {
                        AsyncImage(url:URL(string: card.cardImage)){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.clear
                        }
                        .frame(height: 100)
                        
                        VStack(alignment: .leading) {

                            ForEach(Array(card.categorys.enumerated()), id:\.offset){ index, card in
                                HStack{
                                    if index < 4{
    //                                    Text(card.category)
                                        switch card.category{
                                        case "cafe":
                                            Image(systemName: "cup.and.saucer.fill")
                                            Text("카페/베이커리")
                                                
                                                
                                        case "mart":
                                            Image(systemName: "cart.fill")
                                            Text("마트")
                                        case "telephone":
                                            Image(systemName: "iphone")
                                            Text("통신")
                                        case "medical":
                                            Image(systemName: "cross.case.fill")
                                            Text("의료")
                                        case "leisure":
                                            Image(systemName: "mountain.2.fill")
                                            Text("레저")
                                        case "shopping":
                                            Image(systemName: "handbag.fill")
                                            Text("쇼핑")
                                        case "cinema":
                                            Image(systemName: "film.fill")
                                            Text("영화관")
                                        case "eatout":
                                            Image(systemName: "fork.knife")
                                            Text("외식")
                                        case "transport":
                                            Image(systemName: "bus")
                                            Text("대중교통")
                                        case "cvs":
                                            Image(systemName: "basket.fill")
                                            Text("편의점")
                                        case "culture":
                                            Image(systemName: "play.tv")
                                            Text("문화")
                                        case "beauty":
                                            Image(systemName: "wand.and.stars.inverse")
                                            Text("뷰티")
                                        case "insurance":
                                            Image(systemName: "car.2.fill")
                                            Text("보험사")
                                        case "auto":
                                            Image(systemName: "wrench.and.screwdriver.fill")
                                            Text("오토")
                                        case "gasStation":
                                            Image(systemName: "fuelpump.fill")
                                            Text("주유소")
                                        case "easyPayment":
                                            Image(systemName: "creditcard")
                                            Text("간편결제")
                                        case "baby":
                                            Image(systemName: "teddybear")
                                            Text("육아")
                                        case "airport":
                                            Image(systemName: "airplane")
                                            Text("프리미엄")
                                        case "point":
                                            Image(systemName: "wonsign.square.fill")
                                            Text("포인트")
                                        case "maintain":
                                            Image(systemName: "banknote")
                                            Text("관리비")
                                        default:
                                            Image(systemName: "star.fill")
                                        }
                                        
                                    }
                                }.font(.body)        //.font(.caption)
                               
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
                    vm.addUsersData(cardName: card.cardName, cardImage: card.cardImage)
                }
                
            }
        }
        
    } // ZStack1
}

struct AddCardCell_Previews: PreviewProvider {
    static var previews: some View {
        AddCardCell(card: CardName(id: " ", cardImage: " ", cardName: " ", categorys: []) ).environmentObject(ViewModel())
    }
}
