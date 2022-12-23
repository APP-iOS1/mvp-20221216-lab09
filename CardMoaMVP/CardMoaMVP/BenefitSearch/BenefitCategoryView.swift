//
//  BenefitCategoryView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/20.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
}

struct BenefitCategoryView: View {
    let items = [
        Item(title: "외식", image: "fork.knife"),
        Item(title: "카페", image: "cup.and.saucer.fill"),
        Item(title: "대형마트", image: "cart.fill"),
        Item(title: "대중교통", image: "bus"),
        Item(title: "편의점", image: "basket.fill"),
        Item(title: "레저", image: "mountain.2.fill"),
        Item(title: "의료", image: "cross.case.fill"),
        Item(title: "통신비", image: "iphone"),
        Item(title: "뷰티", image: "wand.and.stars.inverse"),
        Item(title: "문화", image: "play.tv"),
        Item(title: "영화", image: "film.fill"),
        Item(title: "보험사", image: "car.2.fill"),
        Item(title: "주유소", image: "fuelpump.fill"),
        Item(title: "오토", image: "wrench.and.screwdriver.fill"),
        Item(title: "간편결제", image: "creditcard"),
        Item(title: "육아", image: "teddybear"),
        Item(title: "프리미엄", image: "airplane"),
        Item(title: "포인트", image: "wonsign.square.fill"),
        Item(title: "쇼핑", image: "handbag.fill"),
        Item(title: "관리비", image: "banknote"),
    ]
    
    //화면을 그리드형식으로 꽉채워줌
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let roundRectangle : RoundRectangle = RoundRectangle()
    @Binding var search : String
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    HStack {
                        Text("최근 검색어")
                            .font(.title3).padding(.leading, 20).fontWeight(.bold)
                        Spacer()
                        Button {
                            // ???: - 배민 참고해서 만듦, 배민에서는 전체삭제하면 최근검색어hstack자체가 없어지긴 함..! 어떻게 할지?
                        } label: {
                            Text("전체삭제")
                                .font(.subheadline)
                                .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
                                .background(Color.lightGray)
                                .foregroundColor(Color.black)
                                .cornerRadius(30)
                                .padding(.trailing, 20)
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            NavigationLink {
                                // 최근검색어에 있는 버튼 클릭시 검색(돋보기)버튼과 같은 맥락
                                CardResultView(search: $search)
                            } label: {
                                Text("스타벅스").modifier(roundRectangle)
//                                Text("\(search)").modifier(roundRectangle)
                            }
                        }
                    }.padding(.leading)
                    
                    Rectangle().frame(height : 10).foregroundColor(.lightGray).padding([.top])
                    HStack{
                        Text("혜택 모아보기")
                            .font(.title3)
                            .padding(.leading, 20)
                            .padding(.top)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(items) {item in
                            NavigationLink {
                                BenefitCategoryDetailView()
                            } label: {
                                ItemView(item: item)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                
            }
        }
    }
}

struct ItemView: View {
    let item: Item
    var body: some View {
        GeometryReader { reader in
            VStack(spacing: 5) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.lightPink)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    )
                
                Text(item.title)
                    .padding(.top, 3)
                //                    .font(.system(size: 20))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            //            .background(Color.blue)
            .cornerRadius(10)
            .foregroundColor(.black)
        }
        .frame(height: 90)
    }
}

struct RoundRectangle : ViewModifier {
    func body(content: Content) -> some View {
        content.padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10)).background(Color.lightPink).cornerRadius(30).foregroundColor(.mainColor).fontWeight(.semibold)
    }
}

struct BenefitCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitCategoryView(search: .constant("임시용"))
    }
}

