//
//  AddMyCardView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/20.
//

import SwiftUI

class CurrentCompanyStore: ObservableObject {
    @Published var companyName = "삼성카드"
}

struct AddMyCardView: View {
    @State private var segmentationSelection2 = 0
    @EnvironmentObject var vm : ViewModel
    @Binding var currentCompany: String
    @ObservedObject var currentCompanyStore = CurrentCompanyStore()

    @State var showingSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Spacer()
                    HStack {
                        // 신용카드, 체크카드
                        SegmentedControlView(currentTab: $segmentationSelection2)
                            .padding(.leading, 8)

                        Spacer()
                        
                        // 카드사
                        Button {
                            showingSheet.toggle()
                        } label: {
                            VStack {
                                HStack {
                                    Text(currentCompany)
                                        .lineLimit(1)
                                       // .font(.title2)
                                        .foregroundColor(.black)
                                        .bold()
                                        .padding(.top, 9)
                                        .padding(.trailing, 40)
                                    Image(systemName: "chevron.down")
                                        .padding(.trailing, 20)
                                        .padding(.top, 9)
                                }
                                .frame(width: 150)
                                
                                Rectangle()
                                    .foregroundColor(.gray)
                                    .frame(width: 140, height: 3)
                                    .padding(.trailing, 20)
                                    .padding(.top, -10)
                            }
                        }
                        .sheet(isPresented: $showingSheet)
                        {
                            SelectCompanyView(showingSheet: $showingSheet, currentCompanyStore: currentCompanyStore)
                                .presentationDetents([.height(550)])
                        }
                        
                    }
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    
                    HStack {
                        Spacer()
                        Text("밀어서 카드 추가")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.trailing, 20)
                    }
                    
                        
                    //CardList
                    ForEach(vm.cards) { card in
                        VStack {
                            AddCardCell(card: card)
                        }
                        .onAppear() {
                            currentCompany = currentCompanyStore.companyName
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
        AddMyCardView(currentCompany: .constant("삼성카드")).environmentObject(ViewModel())

    }
}
