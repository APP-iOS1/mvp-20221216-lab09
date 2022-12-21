//
//  ProfileView.swift
//  CardMoaMVP
//
//  Created by 이재희 on 2022/12/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authModel : AuthViewModel
    
    var body: some View {
        NavigationStack{
            VStack{
                Button {
                    authModel.logout()
                } label: {
                    Text("로그아웃")
                }
                .frame(width: 200, height: 45)
                .foregroundColor(.white)
                .background(Rectangle().fill(Color("MainColor")))
                .cornerRadius(10)
                .padding(.top, 40)
            }
//            .navigationTitle("나의 소비")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
