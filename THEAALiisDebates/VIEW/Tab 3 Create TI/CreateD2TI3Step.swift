//
//  CreatTI3rdStep.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/17/24.
//

import SwiftUI

struct CreateD2TI3Step: View {
    
    @Binding var tiDescription: String
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("TI Admins")
                .padding()
            
            
            EditTIAdminsSV()
            
            //Description
            EnterDescriptionButton(description: $tiDescription, buttonTitle: "Enter TI Intro Description")
                .padding(.vertical, width * 0.15)
        }
    }
}

#Preview {
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2))
//    CreatD2TI3Step()
}
