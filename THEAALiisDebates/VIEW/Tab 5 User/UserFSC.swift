//
//  UserFSC.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/9/23.
//

import SwiftUI

struct UserFSC: View {
    
    let user: UserModel?
    
    @Binding var showFSC: Bool
    
    @State private var currentUser: UserModel? = nil
    @AppStorage("current_user_id") var currentUserId: String = ""
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            
            VStack(spacing: 0) {
                
                //Close Button
                HStack() { Spacer(); CloseButton(showFSC: $showFSC ).padding(.all) }
                
                //                if user == nil {
                //                    Text("No User")
                //                } else {
                //MARK: Image
                if user?.profileImageURLString != nil {
                    ZStack {
                        Circle()
                            .stroke()
                            .foregroundColor(.secondary)
                            .frame(width: width * 0.6, height: width * 0.6)
                        
                        AsyncImage(url: URL(string: user!.profileImageURLString!), scale: 1) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: width * 0.6, height: width * 0.6)
                                .clipShape(Circle())
                            
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
                } else {
                    PersonIcon()
                        .foregroundColor(user != nil ? .primary : .secondary)
                }
                
                if user != nil {
                    VStack(spacing: 15) {
                        
                        Text(user!.name != "" ? user!.name : "No Name")
                            .foregroundColor(user!.name != "" ? .primary : .secondary)
                            .font(.title)
                        
                        Text("Future Feature")
                            .foregroundColor(.secondary)
                    }.padding(.vertical)
                } else {
                    Text("User doesn't Exist")
                        .foregroundColor(.secondary)
                        .padding(.vertical)
                    
                }
                
                Divider()
                
                //MARK: User Bio & Buttons
                HStack(spacing: 0) {
                    
                    DescriptionSV(descriptionTitle: "User's Bio", text: user?.bio ?? "")
                    
                    VStack(spacing: 0) {
                        if let user, let currentUser {
                            //Follow
                            FutureFeatureButton()
                            
                            SaveUserButton(user: user, currentUser: currentUser)
                            
                            //Expand
                            FutureFeatureButton()
                        }
                        
                    }
                }
                .frame(width: width, height: width * 0.45)
                .preferredColorScheme(.dark)
                
                //MARK: User Tabs
                UserViewTabsBar()
                
                //MARK: - Posts Array
                LazyVStack {
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<5, id: \.self) { i in
                            
                            //DebateCard() //TODO
                            //VotingCell()///for Public Questions Tab!
                            ///
                            UserPostedDebateCard()
                            
                        }
                    }
                }
                
                //room for the bottom of sheet
                Rectangle()
                    .fill(.black)
                    .frame(height: width * 0.15)
            }
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
        .onAppear{ Task { try await fetchCurrentUser() } }
    }
    
    //MARK: Fetch
    func fetchCurrentUser() async throws {
#if DEBUG
        currentUser = TestingModels().user1
        
#else
        do {
            currentUser = try await UserManager.shared.getUser(userId: currentUserId)
        } catch {
            print("❌⬇️Error: Couldn't fetch current User \n❌[UserFSC]")
            currentUser = nil
        }
#endif
    }
}


struct UserFSC_Previews: PreviewProvider {
    static var previews: some View {
        SaveUserButton(user: TestingModels().user1, currentUser: TestingModels().user1 )
        
        UserFSC(user: TestingModels().user1, showFSC: .constant(true))
        UserButton(
            userUID: "wow"
//            imageURL: TestingImagesVideos().imageURLStringDesignnCode
        )
        //        UserFSC(user: <#UserModel?#>)
    }
}

//MARK: - Save User Button
struct SaveUserButton: View {
    
    let user: UserModel
    @State var currentUser: UserModel
    //    @AppStorage("current_user_id") var currentUserId: String = ""
    @State private var showSavedUsersSheet = false
    
    var body: some View {
        
        Button {
            if currentUser.id != nil {
                Task {
                    try await updateSavedUsers()
                }
            }
        } label: {
            ZStack {
                if userSaved {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .fill(Color.secondary)
                        .frame(width: width * 0.14, height: width * 0.12)
                    
                    Text("User Saved")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 1)
                        .fill(Color.secondary)
                        .frame(width: width * 0.14, height: width * 0.14)
                    
                    Text("Save User")
                        .foregroundColor(.primary)
                }
            }
            .frame(width: width * 0.15, height: width * 0.15)
        }
        .sheet(isPresented: $showSavedUsersSheet) {
            VStack(spacing: 0) {
                Text("User Saved")
                    .font(.title)
                    .frame(width: width)
                
                Text("You can use saved users When Adding admins to THEAALii Interactions you created")
                    .padding(.vertical, width * 0.1)
                
                Spacer()
            }
            .background(Color.black)
            .presentationDetents([.fraction(0.25)])
            .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.dark)
    }
    
    //F
    var userSaved: Bool {
        if let userId = user.id {
            return currentUser.savedUsers?.contains(userId) ?? false
        } else { return false }
    }
    
    func updateSavedUsers() async throws {
        if let userId = user.id, let currentUserId = currentUser.id {
            Task {
                print("🍌 🫒 saved user enter 🫒 🍌")
                if userSaved {
                    try await UserManager.shared.updateSavedUsers(currentUserId: currentUserId ,userIdForArray: userId,addOrRemove: (userSaved ? .remove : .remove))
                    print("🍌 🫒 saved user remove! 🫒 🍌")
                    
                    currentUser.savedUsers?.remove(object: userId)
                } else {
                    try await UserManager.shared.updateSavedUsers(currentUserId: currentUserId ,userIdForArray: userId,addOrRemove: (userSaved ? .remove : .add))
                    print("🍌 🫒 saved user add! 🫒 🍌")
                    
                    currentUser.savedUsers?.append(userId)
                    showSavedUsersSheet.toggle()
                }
            }
        }
    }
}

