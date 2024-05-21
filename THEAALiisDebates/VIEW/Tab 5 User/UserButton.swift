//
//  UserButtonSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/8/23.
//

import SwiftUI

//MARK: - User Button
//struct UserButton2: View {
//
//    //FIXME: - Replace userVM
//    @StateObject var userVM = UserViewModel()
//
//    let userUID: String?
//    var imageURL: String?
//
//    @State private var showUserSheet = false
//
//    var body: some View {
//
//        Button {
//            showUserSheet.toggle()
//        } label: {
//            ZStack {
//
//                Circle()
//                    .frame(width: width * 0.12)
//                    .foregroundColor(.black)
//
//                if userVM.user != nil {
//                    if userVM.user?.profileImageURLString != nil {
//
//                        AsyncImage(url: URL(string: userVM.user?.profileImageURLString ?? ""), scale: 0.5) { image in
//                            image
//                                .resizable()
//                                .clipShape(Circle())
//                                .scaledToFit()
//                                .frame(width: width * 0.15)
//
//                        } placeholder: {
//                            ProgressView()
//                        }
//                    } else { PersonTITIconSV(scale: 1.3) }
//                } else {
//                    VStack {
//                        Text("No")
//                            .font(.system(size: width * 0.03, weight: .light))
//                        Text("User")
//                            .font(.system(size: width * 0.03, weight: .light))
//                    }
//                    .background(.black)
//                    .foregroundColor(.secondary)
//                }
//
//
//                Circle()
//                    .strokeBorder(lineWidth: 0.5)
//                    .frame(width: width * 0.12)
//                    .foregroundColor(.secondary)
//
//            }
//        }
//        .preferredColorScheme(.dark)
//        .onAppear{
//            //FIXME: - Crashed the app
//            Task {
//                if userUID != nil && userUID != "" {
//                    //Valid UID
//                    let userExists = try await UserManager.shared.getUser(userId: userUID!)
//                    if userExists != nil {
//                        try await userVM.loadUser(userID: userUID!)
//                    }
//                }
//            }
//        }
//        .fullScreenCover(isPresented: $showUserSheet) {
//
//            UserFSC(user: userVM.user, showFSC: $showUserSheet)
//        }
//    }
//}

struct UserButton_Previews: PreviewProvider {
    static var previews: some View {
//        UserButton(
//            userUID: "me"
//            //            imageURL: TestingComponents().imageURLStringDesignnCode
//        )
        
        CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2))

    }
}


//MARK: - User Button 2
struct UserButton: View {
    
    var user: UserModel? = nil
    var userUID: String? = nil
    
    var horizontalName = false
    
    //inits
//    init(user: UserModel?) {
//        self.user = user
//        self.userUID = user?.userUID
//    }
//    init(userUID: String?) {
//        self.userUID = userUID
//    }
//    //With Horizontal Name
//    init(user: UserModel?, horizontalName: Bool) {
//        self.user = user
//        self.userUID = user?.userUID
//        self.horizontalName = horizontalName
//        
//    }
//    init(userUID: String?, horizontalName: Bool) {
//        self.userUID = userUID
//        self.horizontalName = horizontalName
//    }
    
    
    
    @State private var showUserSheet = false
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            
            
            
            
            //MARK: - Button
            Button {
                showUserSheet.toggle()
            } label: {
                
                HStack(spacing: 0) {
                    
                    //MARK: - Text & Icon
                    if horizontalName {
                        VStack(spacing: 0) {
                            
                            //User Name
                            Text(computedUser?.displayName ?? "No User")
                                .foregroundStyle(.white)
                                .padding(.trailing, width * 0.01)
                                .frame(width: width * 0.4, height: width * 0.07, alignment: .trailing)
                            
                            Divider()
                                .frame(width: width * 0.2, alignment: .trailing)

                            
                            
                            //User Label
                            (Text(userLabel + " ") + Text(Image(systemName: userLabelIcon)))
                                .foregroundStyle(.gray)
                                .font(.system(size: width * 0.03, weight: .regular))
                                .padding(.trailing, width * 0.01)
                                .frame(width: width * 0.4, height: width * 0.04, alignment: .trailing)
                        }
                        .frame(width: width * 0.4, height: width * 0.12, alignment: .top)
                    }
                    
                    ZStack {
                        
                        //Black Background
                        Circle()
                            .frame(width: width * 0.12)
                            .foregroundColor(.black)
                        
                        if let computedUser {
                            if let profileImageURLString = computedUser.profileImageURLString {
                                
                                AsyncImage(url: URL(string: profileImageURLString), scale: 0.5) { image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .scaledToFit()
                                        .frame(width: width * 0.12)
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                //User with Nil image
                            } else { PersonTITIconSV(scale: 1.3) }
                            
                            //User Doesn't exist
                        } else {
                            VStack {
                                Text("No")
                                    .font(.system(size: width * 0.03, weight: .light))
                                Text("User")
                                    .font(.system(size: width * 0.03, weight: .light))
                            }
                            .background(.black)
                            .foregroundColor(.secondary)
                        }
                        
                        //Border
                        Circle()
                            .strokeBorder(lineWidth: 0.5)
                            .frame(width: width * 0.12)
                            .foregroundColor(.primary)
                        
                    }
                }
            }
            .preferredColorScheme(.dark)
            //        .onAppear{
            //            //FIXME: - Crashed the app
            //            Task {
            //                if userUID != nil && userUID != "" {
            //                    //Valid UID
            //                    let userExists = try await UserManager.shared.getUser(userId: userUID!)
            //                    if userExists != nil {
            //                        try await loadUser(userUID: userUID!)
            //                    }
            //                }
            //            }
            //        }
//            .onAppear{ Task { try await loadUser() } }
            .fullScreenCover(isPresented: $showUserSheet) {
                
                UserFSC(user: computedUser, showFSC: $showUserSheet)
            }
        }
    }
    
    //MARK: - Functions
//    func loadUser() async throws {
//        
//        
//        //        guard let userUID = userUID else { return }
//        
//        if user == nil {
//            //        if user?.userUID != nil && userUID != "" {
//#if DEBUG
//            //            self.user = TestingModels().user
//            //            self.user = nil
//#else
//            do {
//                /*
//                 if getting user is [successful]   user = UserModel(...)
//                 if getting user is [UNsuccessful] user = nil
//                 */
//                self.user = try await UserManager.shared.getUser(userId: userUID ?? "")
//            } catch {
//                print("🏀🟠🏀 Couln't get user")
//                print(error.localizedDescription)
//            }
//#endif
//        }
//    }
    
    //MARK: - Computed Properties
    var computedUser: UserModel? {
//        guard user == nil else { return user }
        if user != nil { return user }
        if userUID == nil { return nil}
//        guard userUID != nil else { return nil }
        
        //3. user    && id          -> XXXX
        //4. user    && no id       -> XXXX
        
        //1. no user && we have UID -> Lookup in database
        //2. no user && no UID      -> return nil
        
        if userUID != nil {
#if DEBUG
//            return TestingModels().user3
            return TestingModels().userArray.randomElement()

#else
            do {
                /*
                 if getting user is [successful]   user = UserModel(...)
                 if getting user is [UNsuccessful] user = nil
                 */
//                self.user = try await UserManager.shared.getUser(userId: userUID ?? "")
                return try await UserManager.shared.getUser(userId: userUID ?? "")
            } catch {
                print("🏀🟠🏀 Couln't get user")
                print(error.localizedDescription)
            }
#endif
        }
        return nil
    }
    
    //Label
    var userLabel: String {
        guard let computedUser else { return "No User" }
        
        if !computedUser.createdTIsIDs.isEmpty {
            return "Creator"
        } else {
            return "Observer"
        }
    }
    var userLabelIcon: String {
        guard let computedUser else {  return "xmark" }
        
        if !computedUser.createdTIsIDs.isEmpty {
            
            return "plus.square.fill"
            
        } else {
            
            return "eye"
        }
    }
}







///         func loadUser() {
////        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
////        if userID != nil {
//        do {
//            self.user = try await UserManager.shared.getUser(userId: userUID)
//        } catch {
//            print("🏀🟠🏀 Couln't get user")
//            print(error.localizedDescription)
////            throw error.localizedDescription
//        }
////        }
///    }
