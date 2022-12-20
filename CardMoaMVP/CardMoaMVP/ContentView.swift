//
//  ContentView.swift
//  CardMoaMVP
//
//  Created by dev on 2022/12/19.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authModel : AuthViewModel
    
    var body: some View {
        VStack {
            if authModel.currentUser == nil{
                LoginView()
            }else{
                TestView()
            }

        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel())
    }
}
