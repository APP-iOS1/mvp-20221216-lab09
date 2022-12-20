//
//  LoginView.swift
//  CardMoaMVP
//
//  Created by 지정훈 on 2022/12/20.
//

import SwiftUI

struct LoginView: View {
    @State var idText : String = ""
    @State var passwordText : String = ""
    
    @State var signUpBool : Bool = false
    
    @EnvironmentObject var authModel : AuthViewModel
    
    @State var creatAlert : Bool = false
    @State var alertMessage : String = ""
    
    func message(alertMessage : String) -> Alert {
        Alert(
            title: Text("실패"),
            message: Text("\(alertMessage)"),
            dismissButton: .default(Text("닫기")))
        
    }
    
    var body: some View {
        VStack{
            TextField("아이디", text: $idText)
            SecureField("비밀번호", text: $passwordText)
            
            Button {
                authModel.loginUser(email: idText, password: passwordText){ codeValue in
                    switch codeValue {
                    case 200:
                        print("성공")
                    case 17008:
                        alertMessage = "이메일 형식이 아닙니다."
                        creatAlert = true
                    case 17009:
                        alertMessage = "비밀번호가 다릅니다."
                        creatAlert = true
                    default:
                        alertMessage = "고려하지 못한 에러입니다~~"
                        creatAlert = true
                    }
                }
            } label: {
                Text("로그인")
            }
            Button {
                signUpBool.toggle()
            } label: {
                Text("회원가입")
            }
            
            
        }.padding()
            .fullScreenCover(isPresented: $signUpBool) {
                SignUpView()
            }.alert(isPresented: self.$creatAlert,
                    content: { self.message(alertMessage: alertMessage) })
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
