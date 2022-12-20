//
//  SignUpView.swift
//  CardMoaMVP
//
//  Created by 지정훈 on 2022/12/20.
//

import SwiftUI

struct SignUpView: View {
    
    @State var nameText : String = ""
    @State var idText : String = ""
    @State var passwordText : String = ""
    @State var passwordCheckText : String = ""
    
    @State var creatAlert : Bool = false
    @State var alertMessage : String = ""
    
    @EnvironmentObject var authModel : AuthViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    func message(alertMessage : String) -> Alert {
        Alert(
            title: Text("실패"),
            message: Text("\(alertMessage)"),
            dismissButton: .default(Text("닫기")))
        
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("이름", text: $nameText)
                
                HStack{
                    TextField("아이디", text: $idText)
                    Button {
                        
                    } label: {
                        Text("중복체크")
                    }
                }
                
                SecureField("비밀번호", text: $passwordText)
                
                SecureField("비밀번호 확인", text: $passwordCheckText)
                
                Button {
                    authModel.signUp(name: nameText, userId: idText, userPassword: passwordText) { intValue, uidValue  in
                        switch intValue {
                        case 200: //회원가입 성공
                            print("성공")
                            dismiss()
                        case 17007:
                            print("이미 가입한 계정")
                            alertMessage = "이미 가입된 계정입니다."
                            creatAlert = true
                        case 17008:
                            print("맞지 않는 포맷")
                            alertMessage = "이메일 형식이 올바르지 않습니다."
                            creatAlert = true
                        case 17026:
                            print("비밀번호를 6자리 이상 입력")
                            alertMessage = "비밀번호를 6자리 이상 입력해주세요."
                            creatAlert = true
                        default:
                            print("오류")
                        }
                    }
                    
                } label: {
                    Text("회원가입")
                }
                
                
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("돌아가기")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                }
            }
        }.alert(isPresented: self.$creatAlert,
                content: { self.message(alertMessage: alertMessage) })
        
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AuthViewModel())
    }
}
