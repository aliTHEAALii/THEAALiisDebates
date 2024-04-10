//
//  UserTabView.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/14/23.
//

import SwiftUI

//MARK: - User Tab View
struct UserTabView: View {
    
    @AppStorage("current_user_id"  ) var currentUserUID: String = ""
    @AppStorage("user_name" ) var currentUserName: String = ""
    @AppStorage("user_Pic"  ) var currentUserProfilePicData: Data?
    @AppStorage("log_status") var logStatus: Bool = false
    
    @State var userName       = ""
    @State var currentUserBio = ""
//    @State var userProfilePicData: Data?
    
//    @Environment(\.dismiss) var dismiss
//    @State var showImagePicker = false
//    @State var photoItem: PhotosPickerItem?
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                // - Pick Your Profile Pic
                PickProfileImageButton()
                
                // - Name & Bio
                VStack(spacing: 15) {
                    Text(currentUserUID)
                    Text(currentUserName != "" ? currentUserName : "No Name")
                        .foregroundColor(currentUserName != "" ? .primary : .secondary)
                        .font(.title)
                    
                    Text("Future Feature")
                        .foregroundColor(.secondary)
                }

                // -
                UserBioAndButtons(bio: currentUserBio)
                
                Divider()
                
                // - User Tabs
                UserViewTabsBar()
                
                // - Posts Array
                LazyVStack {
                    ScrollView(showsIndicators: false) {
                        ForEach(0..<5, id: \.self) { i in
                            
//                            DebateCard() //TODO
//                            VotingCell()///for Public Questions Tab!
                            ///
                            UserPostedDebateCard()
                            
                        }
                    }
                }
                

                Spacer()
            }
        }
    }
}

struct UserTabView_Previews: PreviewProvider {
    static var previews: some View {
        UserTabView()
            .preferredColorScheme(.dark)

    }
}
