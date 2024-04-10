////
////  THEAALiisDebatesApp.swift
////  THEAALiisDebates
////
////  Created by Ali Kadhum on 4/5/24.
////
//
//import SwiftUI
//
//@main
//struct THEAALiisDebatesApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

//
//  THEAALiisDebatesApp.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 2/20/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        print("👍🏼 firebase configured")
        
        return true
    }
}

@main
 struct THEAALiisDebatesApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
//                ContentView()
                RootView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
