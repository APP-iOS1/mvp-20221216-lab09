//
//  CardMoaMVPApp.swift
//  CardMoaMVP
//
//  Created by dev on 2022/12/19.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CardMoaMVPApp: App {
    
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel()).environmentObject(ViewModel())
        }
    }
}
