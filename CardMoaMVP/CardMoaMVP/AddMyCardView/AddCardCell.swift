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
                        Button {
                            vm.addUsersData(cardName: card.cardName, cardImage: card.cardImage)
                        } label: {
                            Image(systemName : "plus.circle")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 45)
                        
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
                                if index < 4 {
                                    HStack {

                                        Image(systemName: CategoryImage[card.category] ?? "")
                                        Text(CategoryName[card.category] ?? "")

                                    }
                                }
                                
                            }
        
                            NavigationLink(destination: EmptyView()) {
                                Text("카드정보 더보기")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 45)
                                    .padding(.top, 80)
                            }

                        }
                        
                    }
                }

            } // ZStack2
            .alert("카드를 추가하시겠습니까?", isPresented: $showingAlert) {
                Button("Cancel", role: .cancel) {}
                Button("OK") {
                  vm.addUsersData(cardName: card.cardName, cardImage: card.cardImage)
                }
                
            }
        }
}

struct AddCardCell_Previews: PreviewProvider {
    static var previews: some View {
        AddCardCell(card: CardName(id: " ", cardImage: " ", cardName: " ", categorys: []) ).environmentObject(ViewModel())
    }
}
