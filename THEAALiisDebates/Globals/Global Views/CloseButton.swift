//
//  CloseButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/24/23.
//

import SwiftUI

struct CloseButton: View {
    
    @Binding var showFSC: Bool
    
    var body: some View {
        
        Button {
            showFSC.toggle()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: width * 0.075, weight: .thin))
                .foregroundColor(.primary)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CloseButton(showFSC: .constant(false))
}
