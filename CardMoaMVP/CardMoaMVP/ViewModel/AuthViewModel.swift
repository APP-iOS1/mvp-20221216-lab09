//
//  AuthViewModel.swift
//  CardMoaMVP
//
//  Created by 지정훈 on 2022/12/20.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthViewModel : ObservableObject{
    @Published var currentUser : Firebase.User?
    @Published var loginedUserName : String = ""
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    // MARK: 회원가입
    func signUp(name: String, userId: String, userPassword: String, completion: @escaping (Int, String) -> () ){
        Auth.auth().createUser(withEmail: userId, password: userPassword){ result , error in
            if let error {
                let code = (error as NSError).code
                print("Error \(error.localizedDescription)")
                print(code)
                completion(code, "")
            }
            else {
                
                if let user = Auth.auth().currentUser?.createProfileChangeRequest() {
                    //Auth 시 유저이름 및 포토 URL을 함께 저장
                    // name -> 닉네임
                    user.displayName = name
                    user.commitChanges(completion: {error in
                        if let error = error {
                            print(error)
                        } else {
                            print("DisplayName changed")
                        }
                    })
                }
                
                let uid = result?.user.uid
                completion(200, uid ?? "") //성공 번호
            }
            
        }
        
    }
    
    // MARK: 로그인
    func loginUser(email: String, password: String, completion : @escaping (Int) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                let code = (error as NSError).code
                print(code)
                print(error.localizedDescription)
                completion(code)
            } else {
                
                if let user = Auth.auth().currentUser {
                    self.loginedUserName = user.displayName ?? ""
                    print(self.loginedUserName)
                    
                    
                    
                    print("Successfully logged in as user: \(result?.user.uid ?? "")")
                    self.currentUser = result?.user
                    completion(200)
                }
            }
        }
    }
    
    // MARK: 로그아웃
    func logout() {
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    //Users -> 회원가입 시 받아서 돌려주는???
//    func addUserData(){
//        database.collection("Users").document(Auth.auth().currentUser?.uid)
//    }
}

