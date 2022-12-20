//
//  AddMyCardView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

struct AddMyCardView: View {
    @State private var segmentationSelection2 = 0
    @State private var company = "현대카드"
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        // 신용카드, 체크카드
                        SegmentedControlView(currentTab: $segmentationSelection2)
                            .padding(.leading)

                        Spacer()
                        
                        // 카드사
                        Button {
                            showingSheet.toggle()
                        } label: {
                            VStack {
                                HStack {
                                    Text(company)
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        .bold()
                                        .padding(.top, 9)
                                        .padding(.trailing, 30)
                                    Image(systemName: "chevron.down")
                                        .padding(.trailing, 20)
                                        .padding(.top, 9)
                                }
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: 150, height: 3)
                                    .padding(.trailing, 20)
                                    .padding(.top, -10)
                            }
                        }
                        .sheet(isPresented: $showingSheet)
                        {
                            SelectCompanyView()
                                .presentationDetents([.height(550)])
                        }
                        
                    }
                    .padding(.bottom, 40)
                    
                    //CardList
                    ForEach(Card.cardList) { card in
                        VStack {
                            AddCardListView(card: card)
                            
                        }
                        .padding(.bottom, 30)
                    }
                    .navigationTitle("카드 추가")
                }
            }
        }
    }
}

struct AddMyCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddMyCardView()
    }
}
