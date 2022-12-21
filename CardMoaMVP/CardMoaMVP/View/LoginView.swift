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
            Spacer()
            Image("logoImg")
                .resizable()
                .scaledToFit()
                .frame(width: 180)
                .padding(.bottom, 50)
            EmailFieldSection
                .padding(.bottom)
            PasswordFiledSection
            
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
                    .bold()
            }
            .frame(width: 200, height: 45)
            .foregroundColor(.white)
            .background(Rectangle().fill(Color("MainColor")))
            .cornerRadius(10)
            .padding(.top, 40)
            
            
            Button {
                signUpBool.toggle()
            } label: {
                Text("회원가입")
            }.padding(.top, 7)
            
            Spacer()
            
        }.padding()
            .fullScreenCover(isPresented: $signUpBool) {
                SignUpView()
            }.alert(isPresented: self.$creatAlert,
                    content: { self.message(alertMessage: alertMessage) })
        
        
        
    }
    
    private var EmailFieldSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "envelope.circle.fill")
                    .foregroundColor(.mainColor)
                Text("이메일")
            }
            TextField("이메일을 입력해주세요", text: $idText)
                .frame(width: 300)
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
                .overlay(Rectangle().frame(height: 2).padding(.top, 30))
                .foregroundColor(.mainColor)
        }
    }
    
    private var PasswordFiledSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(.mainColor)
                Text("비밀번호")
            }
            SecureField("비밀번호를 입력해주세요", text: $passwordText)
                .frame(width: 300)
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
                .overlay(Rectangle().frame(height: 2).padding(.top, 30))
                .foregroundColor(.mainColor)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
