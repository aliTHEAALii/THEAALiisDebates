//
//  EditTIAdminsSV.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/20/24.
//

import SwiftUI

struct EditTIAdminsSV: View {
    
    let currentUser: UserModel?
    @Binding var tiAdminsUIDs: [String]
    
    @State private var showEditAdmins = false
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            //
            HStack(spacing: 0) {
                //TI Creator
                UserButton(user: currentUser)
                    .padding(.leading, width * 0.02)
                
                Divider()
                    .padding(.leading, width * 0.02)
                
                //Admins
                ForEach(tiAdminsUIDs, id: \.self) { adminUID in
                    
                    UserButton(userUID: adminUID)
                        .padding(.leading, width * 0.02)
                }
            }
            .frame(width: width * 0.85, alignment: .leading)
            
            //Edit Button
            Button {
                showEditAdmins.toggle()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: width * 0.001)
                        .frame(width: width * 0.12, height: width * 0.12)
                    
                    Text("Edit")
                }
                .frame(width: width * 0.15, height: width * 0.15)
                .foregroundStyle(.white, .white)
            }
            //MARK: - Full Screen Cover
            .fullScreenCover(isPresented: $showEditAdmins) {
                
                FSCHeaderSV(showFSC: $showEditAdmins, text: "Edit Admins")
                
                HStack {
                    Text("TI Creator")
                    
                    Spacer()
                    
                    UserButton(user: currentUser, horizontalName: true)
                }
                .frame(width: width, height: width * 0.15, alignment: .trailing)
                .padding(.vertical)
                
                Divider()
                
                //admins
                if let currentUser = currentUser {
                    ForEach(currentUser.savedUsers, id: \.self) { savedUserUID in
                        HStack {
                            
//                            UserButton(userUID: savedUserUID, horizontalName: true)

                            AddRemoveCTiAdminCell(
                                currentUser: .constant(currentUser),
                                userUID: savedUserUID,
                                addOrRemove: .add)
                        }
                        .frame(width: width, height: width * 0.15, alignment: .trailing)
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: width, height: width * 0.2)
    }
    
    func addOrRemoveAdmin(adminUID: String) {
        guard let currentUser else { return }
        
        if currentUser.savedUsers.contains(adminUID) {
            tiAdminsUIDs.remove(object: adminUID)
        }
        
        if !currentUser.savedUsers.contains(adminUID) {
            tiAdminsUIDs.append(adminUID)
        }
    }
}

#Preview {
//    EditTIAdminsSV()
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 2)

}


//MARK: Add Remove Create Ti Admin Cell
struct AddRemoveCTiAdminCell: View {
    
    
    @Binding var currentUser: UserModel
    
    let userUID: String?
    
    let addOrRemove: AddOrRemove
    
    var body: some View {
        
        
        HStack(spacing: 0) {
            
            
            Button {
                Task {
                    if addOrRemove == .add {
                        try await addUserToAdmins()
                    } else if addOrRemove == .remove {
                       try await removeAdmin()
                    }
                }
            } label: {
                Image(systemName: addOrRemove == .add ? "plus.circle" : "minus.circle")
                    .font(.title)
                    .foregroundColor(addOrRemove == .add ? .ADColors.green : .red)
            }
            .padding()
            
            Spacer()
            
            UserButton(userUID: userUID, horizontalName: true)
        }
    }
    
    private func addUserToAdmins() async throws {
        guard let userUID else { return }
        
//        tr/*y await TITManager.shared.addOrRemoveAdmin(tiId: ti.id, userId: userUID, addO*/rRemove: .add)
        
//        ti.administratorsUID.append(userUID)
    }
    
    private func removeAdmin() async throws {
        guard let userUID else { return }

//        try await TITManager.shared.addOrRemoveAdmin(tiId: ti.id, userId: userUID, addOrRemove: .remove)

        
//        ti.administratorsUID.remove(object: userUID)
    }
}
