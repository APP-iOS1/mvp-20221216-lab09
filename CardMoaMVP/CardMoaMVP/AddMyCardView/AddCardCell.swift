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
                    //                    vm.addUsersData(cardName: card.cardName, cardImage: card.cardImage)
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


//[   CardMoaMVP.CardName(id: "idOn", cardImage: "https://vertical.pstatic.net/vertical-cardad/creatives/SS/3881/SS_3881_hor.png", cardName: "idOn", categorys: [                                                                                                  CardMoaMVP.Category(id: "idOn", discount: "30%", store: Optional(["스타벅스", "이디야커피", "커피빈", "투썸플레이스", "블루보틀", "쉐이크쉑", "써브웨이", "파리바게트", "배스킨라빈스", "던킨"]), exception: Optional(""))        ,                                                        CardMoaMVP.Category(id: "idOn", discount: "10%", store: Optional(["넷플릭스", "웨이브", "티빙", "왓챠", "멜론", "FLO"]), exception: Optional("")),                                                                                                   CardMoaMVP.Category(id: "idOn", discount: "1% ~ 3% 결제일 할인", store: Optional(["삼성페이", "네이버페이", "카카오페이", "PAYCO", "스마일페이", "coupay", "SSGPAY", "L.PAY"]), exception: Optional("해외 : 해외 가맹점 및 해외 직접구매 이용건@전월 이용금액대별 통합(온라인 간편결제·해외 ) 월 할인율 : 30만원 미만 1% / 30만원 이상 3% / 60만원 이상 3%@전월 이용금액대별 통합(온라인 간편결제·해외 ) 월 할인한도 : 30만원 미만 - / 30만원 이상 5,000원 / 60만원 이상 10,000원")),                                                                                                   CardMoaMVP.Category(id: "idOn", discount: "30%", store: Optional(["배달의민족", "요기요"]), exception: Optional("")), CardMoaMVP.Category(id: "idOn", discount: "10%", store: Optional(["SKT", "KT", "LG U+", "알뜰폰"]), exception: Optional("")), CardMoaMVP.Category(id: "idOn", discount: "10%", store: Optional(["버스", "지하철", "택시"]), exception: Optional(""))]),                                                                                                                                                CardMoaMVP.CardName(id: "idSimple", cardImage: "https://vertical.pstatic.net/vertical-cardad/creatives/SS/10157/SS_10157_20220708-131044_ver.png", cardName: "idSimple", categorys:                                                                                                   [CardMoaMVP.Category(id: "idSimple", discount: " 0.7 ~ 1%할인", store: Optional([]), exception: Optional("전월이용금액에관계없이, 할인한도없이 국내외가맹점에서건별10만원미만결제 시0.7% 결제일할인@전월이용금액에관계없이, 할인한도없이 국내외가맹점에서건별10만원이상결제 시 1% 결제일할인")),             CardMoaMVP.Category(id: "idSimple", discount: "영화3,000원할인", store: Optional(["롯데시네마", "CGV", "메가박스"]), exception: Optional("")),                                                                                                   CardMoaMVP.Category(id: "idSimple", discount: " 0.7 ~ 1%할인", store: Optional([]), exception: Optional("전월이용금액에관계없이, 할인한도없이 국내외가맹점에서건별10만원미만결제 시0.7% 결제일할인@전월이용금액에관계없이, 할인한도없이 국내외가맹점에서건별10만원이상결제 시 1% 결제일할인")), CardMoaMVP.Category(id: "idSimple", discount: "온라인쇼핑몰 멤버십 50%할인", store: Optional(["쿠팡로켓와우멤버십", "마켓컬리컬리패스", "네이버플러스멤버십"]), exception: Optional(""))]),                                                                                                                                                                                                     CardMoaMVP.CardName(id: "taptapO", cardImage: "https://vertical.pstatic.net/vertical-cardad/creatives/SS/1530/SS_1530_hor.png", cardName: "taptapO", categorys:                                                                                                   [CardMoaMVP.Category(id: "taptapO", discount: "연 최대 12만원 할인@스타벅스 50% 또는 카페 30%할인", store: Optional(["스타벅스"]), exception: Optional("")),                                                                                                                    CardMoaMVP.Category(id: "taptapO", discount: "연 최대 6만원 할인", store: Optional([]), exception: Optional("CGV·롯데시네마 5,000원 할인@CGV 및 롯데시네마 영화티켓 1만원 이상 결제 시 5,000원 결제일할인@한도조건: 통합 일 1회, 월 2회, 연 12회 제공 (전월 일시불 및 할부 이용금액 30만원 이상 시 제공)")),                                                                                                                           CardMoaMVP.Category(id: "taptapO", discount: "7%할인 또는 1%적립", store: Optional([]), exception: Optional("편의점(쇼핑업종과 통합적용)에서 7% 결제일할인 또는 1% 빅포인트 적립 중 선택@한도조건: (쇼핑업종 할인한도와 통합하여 적용) 월 5천원@실적조건: (할인) 전월 일시불 및 할부 이용금액 30만원 이상")), CardMoaMVP.Category(id: "taptapO", discount: "월 최대 3만원, 연간 36만원 할인@쇼핑 1% 빅포인트 적립", store: Optional([]), exception: Optional("")),                                                                                                   CardMoaMVP.Category(id: "taptapO", discount: "11번가·G마켓 등 연최대 6만원할인@7% 할인 또는 1% 적립", store: Optional([]), exception: Optional("")),                                                                                                   CardMoaMVP.Category(id: "taptapO", discount: "10%", store: Optional([]), exception: Optional("SKT, KT, LG U+ 이동통신요금 자동납부 카드 연결 시 10% 결제일할인")),                                                                                                   CardMoaMVP.Category(id: "taptapO", discount: "10%", store: Optional([]), exception: Optional("버스(시외·고속버스 제외), 지하철, 택시 10% 결제일할인"))])
//]


                                       
