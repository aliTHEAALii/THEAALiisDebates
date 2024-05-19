//
//  PickUserButton.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/13/24.
//

import SwiftUI

//MARK: - Button
struct PickUserButton: View {
    
    
    let currentUser: UserModel?
    @Binding var pickedUser: UserModel?
    
    @State private var showPickUserFSC = false
    
    var body: some View {
        
        Button {
            showPickUserFSC.toggle()
        } label: {
            PickTiUserIcon(
                pickedUser: $pickedUser, showPickUserFSC: $showPickUserFSC)
            .frame(width: width * 0.15)
        }
        .sheet(isPresented: $showPickUserFSC) {
            
            Text("Pick User From your saved Users")
                .font(.title2)
                .padding(.vertical, width * 0.15)
            
            if let currentUser {
                
                PickTiUserCell(savedUserUID: currentUser.userUID, pickedUser: $pickedUser, showPickUserFSC: $showPickUserFSC)
                
                Divider()
                
                ForEach(currentUser.savedUsersUIDs, id: \.self) { savedUserUID in
                    
                    if pickedUser?.userUID == savedUserUID {
                        
                    } else {
                        PickTiUserCell(savedUserUID: savedUserUID ?? "",
                                       pickedUser: $pickedUser,
                                       showPickUserFSC: $showPickUserFSC)
                    }
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
//    PickUserButton()
//    AddD2Info(tiID: "", tiInteractionType: .constant(.d2), tiThumbnailData: .constant(nil), thumbnailForTypeID: "", tiTitle: .constant(""), leftUser: .constant(nil), rightUser: .constant(nil))
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2))
}


//MARK: - Icon
struct PickTiUserIcon: View {
    
    @Binding var pickedUser: UserModel?
    
    @Binding var showPickUserFSC: Bool
    
    
    var body: some View {
        
        ZStack {
            
            if pickedUser == nil {
                //Border
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(pickedUser != nil ? .white : .red)
                    .frame(width: width * 0.125)
                
                //User Image
                PersonTITIconSV(color: .red, scale: 1.4)
                
            } else {
                
                if let profileImageURLString = pickedUser!.profileImageURLString {
                    
                    AsyncImage(url: URL(string: profileImageURLString), scale: 0.5) { image in
                        
                        image
                            .resizable()
                            .clipShape( Circle() )
                            .scaledToFit()
                            .frame(width: width * 0.12)
                        
                    } placeholder: {
                        ProgressView()
                    }
                    //User with Nil image
                } else { PersonTITIconSV(scale: 1.3) }
                
            }
        }
        .frame(height: width * 0.15)
    }
}



//MARK: - Cell
struct PickTiUserCell: View {
    
    var savedUserUID: String
    var savedUser: UserModel? {

        return UserVM().getUser(userUID: savedUserUID)
    }
    @Binding var pickedUser: UserModel?
    
    @Binding var showPickUserFSC: Bool
    
    var body: some View {
        
        
        HStack(spacing: 0) {
            
            
            Button {

                pickedUser = savedUser
                showPickUserFSC = false
                
            } label: {
                Image(systemName: "plus.circle")
                    .font(.title)
                    .foregroundColor(.ADColors.green)
            }
            .padding()
            
            Spacer()
            
            UserButton(userUID: savedUserUID, horizontalName: true)
        }
        .frame(height: width * 0.15)
    }
}
