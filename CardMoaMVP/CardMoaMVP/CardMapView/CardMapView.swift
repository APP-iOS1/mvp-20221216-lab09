//
//  CardMapView.swift
//  CardMoaMVP
//
//  Created by 장다영 on 2022/12/21.
//

import SwiftUI
import MapKit

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var name: String
    var benefit : String
    var coordinate: CLLocationCoordinate2D
}
//혜택 사용처 위도 경도 바꿔서 넣기
var pointsOfInterest = [
    AnnotatedItem(name: "스타벅스 광화문점", benefit: "5% 결제할인", coordinate: .init(latitude: 37.570548, longitude: 126.979042)),
    AnnotatedItem(name: "커피빈 광화문점", benefit: "10% 청구할인", coordinate: .init(latitude: 37.569851, longitude: 126.978983)),
    AnnotatedItem(name: "버거킹 광화문점", benefit: "3% 포인트적립", coordinate: .init(latitude: 37.572545, longitude: 126.980455)),
    AnnotatedItem(name: "파리크라상", benefit: "7% 청구할인", coordinate: .init(latitude: 37.571018, longitude: 126.977844))
]

struct CardMapView: View {
    
    @State private var search : String = ""
    @State private var view : Int = 0
    @State var searchString : String = ""
    @State var selectedCategoryButton: Int = 0
    @State var presentSheet: Bool = false
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.571379, longitude: 126.978678),
        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    )
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
                    Map(coordinateRegion: $region, annotationItems: pointsOfInterest){
                        item in
                        //                기본 MapMarker로 표시하기
                        //                MapMarker(coordinate: item.coordinate, tint: .red)
                        //
                        //                MapAnnotation 사용해서 커스텀 마커로 표시하기
                        MapAnnotation(coordinate: item.coordinate) {
                            Button {
                                // 시트
                                presentSheet.toggle()
                            } label: {
                                VStack {
                                    Image(systemName: "cup.and.saucer.fill")
                                        .resizable()
                                        .foregroundColor(.brown)
                                        .frame(width: 30, height: 30)
                                        .background(.white)
                                        .clipShape(Circle())
                                    
                                    VStack{
                                        Text(item.name).font(.system(size: 15)).fontWeight(.bold).foregroundColor(.black)
                                        Text(item.benefit).font(.system(size: 13)).fontWeight(.bold).foregroundColor(.red)
                                    }.padding(5).background(Color.white.opacity(0.7)).cornerRadius(10)
                                }
                            }
                            .sheet(isPresented: $presentSheet) {
                                sheetView(presentSheet: $presentSheet)
                                    .presentationDetents([.medium])
                            }

                        }
                    }
                }.ignoresSafeArea(edges: .top)
                VStack{
                    HStack{
                        TextField("지역 검색", text: $search)
                        Button {
                            searchString = search
                        } label: {
                            Image(systemName: "magnifyingglass").foregroundColor(.black)
                        }
                    }.padding()
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    CategoryButtons(selectedCategoryButton: $selectedCategoryButton)
                    // 패딩해서 띄워지기는 하나 스크롤하면 들어가는 부분이 이상하긴 함!
                        .padding(.leading, 7)
                    Spacer()
                }
            }
            // 빈 공간을 탭한 경우 키보드 내리기 - 네비게이션 타이틀 아래로는 아무곳이나 터치해도 키보드 내려감
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

// 맵 아이콘 클릭시 올라오는 시트
struct sheetView: View {
    @Binding var presentSheet: Bool
    
    var body: some View {
        VStack{
            Text("상세 시트뷰")
            
        }
    }
}

struct CardMapView_Previews: PreviewProvider {
    static var previews: some View {
        CardMapView()
    }
}
