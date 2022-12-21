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
                            VStack {
                                Image(systemName: "cup.and.saucer.fill")
                                    .resizable()
                                    .foregroundColor(.brown)
                                    .frame(width: 30, height: 30)
                                    .background(.white)
                                    .clipShape(Circle())
                                
                                VStack{
                                    Text(item.name).font(.system(size: 15)).fontWeight(.bold)
                                    Text(item.benefit).font(.system(size: 13)).fontWeight(.bold).foregroundColor(.red)
                                }.padding(5).background(Color.white.opacity(0.7)).cornerRadius(10)
                            }
                        }
                    }
                }.ignoresSafeArea(edges: .top)
                VStack{
                    HStack{
                        TextField("검색어를 입력해주세요", text: $search)
                        Button {
                            searchString = search
                        } label: {
                            Image(systemName: "magnifyingglass").foregroundColor(.black)
                        }
                    }.padding().background(.white).cornerRadius(10).padding()
                    Spacer()
                }
            }
            .toolbarColorScheme(.dark, for: .tabBar)
            .toolbarBackground(
                Color.mainColor,
                for: .tabBar
            )
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct CardMapView_Previews: PreviewProvider {
    static var previews: some View {
        CardMapView()
    }
}
