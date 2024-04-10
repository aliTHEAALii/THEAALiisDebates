//
//  CommentsButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/25/23.
//

import SwiftUI

struct CommentsButton: View {
    var body: some View {
        
        Button {
            
        } label: {
            Image(systemName: "bubble.right")
                .foregroundColor(.secondary)
                .font(.system(size: width * 0.1, weight: .thin))
                .frame(width: width * 0.15, height: width * 0.15)
        }

    }
}

struct CommentsButton_Previews: PreviewProvider {
    static var previews: some View {
        CommentsButton()
    }
}
