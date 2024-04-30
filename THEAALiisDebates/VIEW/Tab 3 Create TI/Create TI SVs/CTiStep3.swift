//
//  CTiStep3.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/25/24.
//

import SwiftUI

struct CTiStep3: View {
    
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
//    CTiStep3()
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2))

}
