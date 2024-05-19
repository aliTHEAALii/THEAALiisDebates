//
//  AdminsList.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/25/23.
//

import SwiftUI

//MARK: - Creator & Admins SV
struct TIAdminsListSV: View {
    
    @Binding var ti: TIModel
    
    @State private var currentUser: UserModel?
    @AppStorage("current_user_id") private var currentUserUID: String = ""
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("TI Administrators")
                .font(.system(size: width * 0.05, weight: .thin))

            
            
            // - Edit Admins
            if currentUserUID == ti.creatorUID {
                if let currentUser {
                    EditAdminsSV(ti: $ti, currentUser: currentUser)
                } else { ProgressView() }
            }
            
            //MARK: admins List
            ForEach(ti.administratorsUID, id: \.self) { adminUID in
                
                HStack(spacing: 0) {
                    Text(adminUID)
                        .foregroundColor(.secondary)
                        .padding(.all)
                        .frame(width: width * 0.85, alignment: .leading)
                    
                    UserButton(userUID: adminUID)
                }
                .frame(height: width * 0.15)
            }
        }
        .onAppear{ Task { try await fetchCurrentUser() } }

    }
    
    func fetchCurrentUser() async throws {
        Task {
//            currentUser = await UserManager.shared.getUser(userId: currentUserId)!
            currentUser = try await UserManager.shared.getUser(userId: currentUserUID)

        }
    }
}

//MARK: - Preview
//struct TIAdminsListSV_Previews: PreviewProvider {
//    static var previews: some View {
//        TIAdminsListSV(ti: .constant(TestingComponents().testingTI))
//    }
//}
//#Preview {
//    TIAdminsListSV(ti: .constant(TestingComponents().testingTI))
//}


//MARK: - Edit Admins SV
struct EditAdminsSV: View {
    
    @Binding var ti: TIModel
    
    @State   var currentUser: UserModel
    @AppStorage("current_user_id") private var currentUserUID: String = ""
    
    var body: some View {
        HStack(spacing: 0) {
            
            //FIXME: - testing Components
            if currentUserUID != TestingModels().user1.userUID {
                RemoveAdminsButton(ti: $ti, currentUser: $currentUser)
                
                Spacer()
                
                //MARK: Add Admin
                AddAdminsButton(ti: $ti, currentUser: $currentUser)
            } else {
                ProgressView()
            }
            
        }
        .padding(.vertical)

    }
}


//MARK: - Add Admin Button
struct AddAdminsButton: View {
    
    @Binding var ti: TIModel
    
    @Binding var currentUser: UserModel
    
    @State private var showAddAdminSheet = false

    var body: some View {
        
        //MARK: Add admin
        Button {
            if currentUser.id == ti.creatorUID {
                showAddAdminSheet.toggle()
            }
        } label: {
            HStack(spacing: 0) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.7)
                        .frame(width: width * 0.3, height: width * 0.1)
                        .foregroundColor(.secondary)
                    
                    Text("Add Admin")
//                                .font(.system(size: width * 0.05, weight: .thin))
                        .foregroundColor(.primary)
                }
//                        .frame(width: width * 0.15)
            }
        }
        .padding(.all)
        //MARK: (Add) Sheet
        .sheet(isPresented: $showAddAdminSheet) {
            VStack(spacing: 0) {
                Text("Admins")
                    .font(.title)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(ti.administratorsUID, id: \.self) { id in
                            UserButton(userUID: id)
                        }
                    }
                }
                .frame(width: width * 0.9, height: width * 0.15)
                
                Text("Saved Users")
                    .font(.title)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(currentUser.savedUsersUIDs ?? [], id: \.self) { userId in
                            
                            if !ti.administratorsUID.contains(userId ?? "") {
                                
//                                Divider()
                                
                                AddRemoveAdminCell(ti: $ti, currentUser: $currentUser, userUID: userId, addOrRemove: .add)
                                
                                Divider()
                            }
                        }
                    }
                }
                
            }// VStack - //
            .preferredColorScheme(.dark)
        }
    }
    
    
}


//MARK: - Remove Admins Button
struct RemoveAdminsButton: View {
    
    @Binding var ti: TIModel
    
    @Binding var currentUser: UserModel
    
    @State private var showRemoveAdminSheet = false

    
    var body: some View {
        
        Button {
            if currentUser.id == ti.creatorUID {
                showRemoveAdminSheet.toggle()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.7)
                    .frame(width: width * 0.3, height: width * 0.1)
                    .foregroundColor(.secondary)
                
                Text("Remove Admin")
                //                            .font(.system(size: width * 0.05, weight: .thin))
                    .foregroundColor(.primary)
            }
        }
        .padding()
        //MARK: (Remove) Sheet
        .sheet(isPresented: $showRemoveAdminSheet) {
            VStack(spacing: 0) {
                Text("Remove Admins")
                    .font(.title)
                    .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(ti.administratorsUID, id: \.self) { id in
                            UserButton(userUID: id)
                        }
                    }
                }
                .frame(width: width * 0.9, height: width * 0.15)
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(ti.administratorsUID, id: \.self) { userId in
                            
                            AddRemoveAdminCell(ti: $ti, currentUser: $currentUser, userUID: userId, addOrRemove: .remove)
                            
                            Divider()
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

//MARK: Add Remove Admin Cell
struct AddRemoveAdminCell: View {
    
    @Binding var ti: TIModel
    
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
        
        try await TITManager.shared.addOrRemoveAdmin(tiId: ti.id, userId: userUID, addOrRemove: .add)
        
        ti.administratorsUID.append(userUID)
    }
    
    private func removeAdmin() async throws {
        guard let userUID else { return }

        try await TITManager.shared.addOrRemoveAdmin(tiId: ti.id, userId: userUID, addOrRemove: .remove)

        
        ti.administratorsUID.remove(object: userUID)
    }
}
