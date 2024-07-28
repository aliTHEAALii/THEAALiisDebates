////
////  RootView.swift
////  THEAALiisDebates
////
////  Created by Ali Kadhum on 4/5/24.
////
//
//import SwiftUI
//
//struct RootView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    RootView()
//}
//

//
//  RootView.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 3/2/24.
//

import SwiftUI

struct RootView: View {
    
    @AppStorage("log_status") var logStatus: Bool = false

    
    @State private var showLoginScreen = false

    
    var body: some View {
        
        ZStack {
            
            if logStatus {
                TabsBar()
            } else {
                LoginScreen()
            }
            
        }
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showLoginScreen = authUser == nil ? true : false
        }
    }
}

#Preview {
    RootView()
}

//New Line lol
