//
//  EditTIAdminsSV.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/20/24.
//

import SwiftUI

struct EditTIAdminsSV: View {
    
    //currentUser
    //currentTI
    
    @State private var showEditAdmins = false
    
    var body: some View {
        HStack(spacing: 0) {
            
            //
            HStack(spacing: 0) {
                //FIXME: - Users' input
                //TI Creator
                UserButton(user: TestingModels().user3)
                    .padding(.leading, width * 0.02)
                
                Rectangle()
                    .frame(width: width * 0.001, height: width * 0.2)
                    .padding(.leading, width * 0.02)
                
                //Admins
                ForEach(0..<4) { i in
                    //FIXME: - Users' input
                    UserButton(user: TestingModels().user2)
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
            .fullScreenCover(isPresented: $showEditAdmins) {
                
                FSCHeaderSV(showFSC: $showEditAdmins, text: "Edit Admins")
                
                //FIXME: User Info
                HStack {
                    Text("TI Creator")
                    
                    Spacer()
                    
                    UserButton(user: TestingModels().user3, horizontalName: true)
                }
                .frame(width: width, height: width * 0.15, alignment: .trailing)
                .padding(.vertical)
                
                Divider()
                
                ForEach(0..<4) { i in
                    HStack {
                        
                        UserButton(userUID: "meaw", horizontalName: true)
//                        UserButton(user: TestingModels().user1, horizontalName: true)
                    }
                    .frame(width: width, height: width * 0.15, alignment: .trailing)
                }
                
                Spacer()
            }
        }
        .frame(width: width, height: width * 0.2)
    }
}

#Preview {
//    EditTIAdminsSV()
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2))

}
