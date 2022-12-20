
import Foundation

struct Card: Identifiable {
    var id = UUID()
    var name: String
    var imgName: String
}

extension Card {
    static var cardList: [Card] = [
        Card(name: "삼성 ID ON", imgName: "Samsung_iDON"),
        Card(name: "삼성 ID PET", imgName: "Samsung_iDPET"),
        Card(name: "삼성 taptap O", imgName: "Samsung_taptapO"),
        Card(name: "삼성 NaverPay", imgName: "Samsung_NaverPay")
    ]
}


struct CompanyName: Identifiable {
    var id = UUID()
    var name: String
}

extension CompanyName {
    static var CompanyList: [CompanyName] = [
        CompanyName(name: "현대"),
        CompanyName(name: "삼성"),
        CompanyName(name: "신한"),
        CompanyName(name: "국민"),
        CompanyName(name: "우리"),
        CompanyName(name: "농협"),
        CompanyName(name: "하나")
    ]
}

struct BenefitCategory: Identifiable {
    var id = UUID()
    var category: String
    var usePrice: String // 사용금액
    var balance: String // 잔액
    var width: CGFloat
}

extension BenefitCategory {
    static var categoryList: [BenefitCategory] = [
        BenefitCategory(category: "커피전문점 50% 청구할인", usePrice: "0 원", balance: "잔여 : 13,000 원", width: 280),
        BenefitCategory(category: "편의점 10% 청구할인", usePrice: "2,195 원", balance: "잔여 : 5,805 원", width: 200),
        BenefitCategory(category: "대중교통 10% 청구할인", usePrice: "3,850 원", balance: "잔여 : 4,150 원", width: 150),
        BenefitCategory(category: "온라인 간편결제 10% 청구할인", usePrice: "1,336 원", balance: "잔여 : 6,664 원", width: 220)
    ]
}
