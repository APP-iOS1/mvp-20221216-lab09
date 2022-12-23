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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50, height: 170)
                .shadow(radius: 5, x: 4, y: 3)
            VStack {
                HStack {
                    Text("\(card.cardName)")
                    Spacer()
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Image(systemName : "plus.circle")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 45)
                    
                }
                .padding(.leading, 40)
                .padding(.bottom, 2)
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
                    .padding(.trailing, 15)
                    VStack(alignment: .leading) {
                        ForEach(Array(card.categorys.enumerated()), id:\.offset){ index, card in
                            if index < 4 {
                                HStack {
                                    
                                    Image(systemName: CategoryImage[card.category] ?? "")
                                    Text(CategoryName[card.category] ?? "")
                                    
                                }
                            }
                            
                        }
                        
                    }
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .foregroundColor(.gray)
                    )
                    .foregroundColor(.gray)
                    
                }
                HStack {
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Text("카드정보 더보기")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.trailing, 45)
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
        AddCardCell(card: CardName(id: " ", cardImage: " ", cardName: " ", categorys:[]) ).environmentObject(ViewModel())
    }
}

