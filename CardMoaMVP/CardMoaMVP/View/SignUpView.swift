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
            VStack(spacing: 10){
                NameFieldSection
                IDFieldSection
                PasswordFieldSection
                PasswordCheckFieldSection
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
                        .bold()
                }.frame(width: 200, height: 45)
                    .foregroundColor(.white)
                    .background(Rectangle().fill(Color("MainColor")))
                    .cornerRadius(10)
                    .shadow(radius: 5, x:5, y:5)
                    .padding()
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                                .bold()
                            Text("돌아가기")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                        }
                    }
                }
            }
        }.alert(isPresented: self.$creatAlert,
                content: { self.message(alertMessage: alertMessage) })
        
        
    }
    
    // MARK: - 이름입력필드
    private var NameFieldSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                    .foregroundColor(.mainColor)
                Text("이름")
                
            }
            HStack {
                TextField("이름을 입력해주세요", text: $nameText)
                    .frame(width: 300)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 30))
                    .foregroundColor(.mainColor)
            }
            Text("\n")
                .font(.caption)
        }
        
    }
    
    // MARK: - 아이디 입력필드
    private var IDFieldSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "key.fill")
                    .foregroundColor(.mainColor)
                Text("아이디")
                
            }
            
            HStack {
                TextField("아이디를 입력해주세요", text: $idText)
                    .frame(width: 210)
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.black)
                    .overlay(Rectangle().frame(height: 2).padding(.top, 30))
                    .foregroundColor(.mainColor)
                Button {

                } label: {
                    Text("중복 확인")
                }
                .frame(width: 80, height: 40)
                .foregroundColor(.white)
                .background(Rectangle().fill(Color("MainColor")))
                .cornerRadius(10)
                .shadow(radius: 5, x:5, y:5)

            }
            Text("\n")
                .font(.caption)
        }
    }
    
    // MARK: - 바밀번호 입력필드
    private var PasswordFieldSection : some View {
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
            
            
            if passwordText.count > 5 {
                Text("사용 가능한 비밀번호입니다.\n")
                    .foregroundColor(.green)
                    .font(.caption)
                
            } else if passwordText.isEmpty == false {
                
                Text("비밀번호는 최소 6자리 이상으로 구성되어야합니다.\n")
                    .foregroundColor(.red)
                    .font(.caption)
                
            } else {
                Text("\n")
                    .font(.caption)
            }
        }
    }
    
    // MARK: - 비밀번호 확인 필드
    private var PasswordCheckFieldSection : some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.mainColor)
                Text("비밀번호 확인")
                
            }
            SecureField("비밀번호를 다시 입력해주세요", text: $passwordCheckText)
                .frame(width: 300)
                .textInputAutocapitalization(.never)
                .foregroundColor(.black)
                .overlay(Rectangle().frame(height: 2).padding(.top, 30))
                .foregroundColor(.mainColor)
            
            
            if (passwordText==passwordCheckText) && !passwordText.isEmpty {
                Text("비밀번호가 일치합니다.\n")
                    .foregroundColor(.green)
                    .font(.caption)
            } else if passwordCheckText.isEmpty == false {
                
                Text("비밀번호가 일치하지 않습니다.\n")
                    .foregroundColor(.red)
                    .font(.caption)
                
            } else {
                Text("\n")
                    .font(.caption)
            }
        }
        
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(AuthViewModel())
    }
}
