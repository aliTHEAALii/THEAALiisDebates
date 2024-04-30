//
//  UserBioAndButtons.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/19/23.
//

import SwiftUI

struct UserBioAndButtons: View {
    
    var bio: String = ""
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            DescriptionSV(descriptionTitle: "User's Bio", text: bio)

            VStack(spacing: 0) {
                
                //Edit
                EditUserInfoButton()

                
                FutureFeatureButton()
                
                FutureFeatureButton()

            }
        }
        .frame(width: width, height: width * 0.45)
        .preferredColorScheme(.dark)
    }
}

struct UserBioAndButtons_Previews: PreviewProvider {
    static var previews: some View {
        UserBioAndButtons()
            .previewLayout(.sizeThatFits)
    }
}
