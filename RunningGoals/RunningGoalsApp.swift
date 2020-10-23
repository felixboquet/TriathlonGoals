//
//  RunningGoalsApp.swift
//  RunningGoals
//
//  Created by Féfé on 22/10/2020.
//

import SwiftUI
import Firebase

@main
struct RunningGoalsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Setting up firebase")
        FirebaseApp.configure()
        return true
    }
    
}
