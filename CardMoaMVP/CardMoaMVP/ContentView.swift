//
//  ContentView.swift
//  CardMoaMVP
//
//  Created by dev on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MyCardView().tabItem {
                    Image(systemName: "creditcard")
                    Text("나의 카드")
                }.tag(1)
                Text("test").tabItem {
                    Image(systemName: "map")
                    Text("내 주변 혜택")
                }.tag(2)
                
                Text("test").tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("혜택 검색")
                }.tag(3)
                Text("test").tabItem {
                    Image(systemName: "list.dash.header.rectangle")
                    Text("카드 추천")
                }.tag(4)
                Text("test").tabItem {
                    Image(systemName: "person.crop.rectangle")
                    Text("나의 소비")
                }.tag(5)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
