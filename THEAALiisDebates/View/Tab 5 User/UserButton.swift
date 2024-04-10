//
//  UserButtonSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/8/23.
//

import SwiftUI

//MARK: - User Button
struct UserButton: View {
    
    @StateObject var userVM = UserViewModel()
    
    let userID: String?
    var imageURL: String?
    
    @State private var showUserSheet = false
    
    var body: some View {
        
        Button {
            showUserSheet.toggle()
        } label: {
            ZStack {
                
                Circle()
                    .frame(width: width * 0.12)
                    .foregroundColor(.black)
                
                if userVM.user != nil {
                    if userVM.user?.profileImageURLString != nil {
                        
                        AsyncImage(url: URL(string: userVM.user?.profileImageURLString ?? ""), scale: 0.5) { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFit()
                                .frame(width: width * 0.15)
                            
                        } placeholder: {
                            ProgressView()
                        }
                    } else { PersonTITIconSV(scale: 1.3) }
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
                
                
                Circle()
                    .strokeBorder(lineWidth: 0.5)
                    .frame(width: width * 0.12)
                    .foregroundColor(.secondary)
                
            }
        }
        .preferredColorScheme(.dark)
        .onAppear{
            //FIXME: - Crashed the app
            Task {
                if userID != nil && userID != "" {
                    let userExists = await UserManager.shared.getUser(userId: userID!)
                    if userExists != nil {
                        try await userVM.loadUser(userID: userID!)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showUserSheet) {
            ZStack(alignment: .topTrailing) {

                UserFSC(user: userVM.user, showFSC: $showUserSheet)
                
                //MARK: Close Button
//                Button {
//                    showUserSheet = false
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width: width * 0.1, height: width * 0.1)
//                            .foregroundColor(.black)
//
//                        RoundedRectangle(cornerRadius: 10)
//                            .strokeBorder(lineWidth: 0.7)
//                            .frame(width: width * 0.1, height: width * 0.1)
//                            .foregroundColor(.white)
//
//                        Image(systemName: "xmark")
//                            .font(.system(size: width * 0.075, weight: .thin))
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.trailing)
//                }
            }
        }
    }
}

struct UserButton_Previews: PreviewProvider {
    static var previews: some View {
        UserButton(
            userID: "me",
            imageURL: TestingComponents().imageURLStringDesignnCode
        )
    }
}

