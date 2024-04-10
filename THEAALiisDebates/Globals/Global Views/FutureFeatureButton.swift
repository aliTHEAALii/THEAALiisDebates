//
//  FutureFeatureButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/19/23.
//

import SwiftUI

struct FutureFeatureButton: View {
    var body: some View {
        Button {
            
        } label: {
            VStack(spacing: 0) {
                Text("Future Feature")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: width * 0.15, height: width * 0.15)
        }
    }
}

struct FutureFeatureButton_Previews: PreviewProvider {
    static var previews: some View {
        FutureFeatureButton()
        
//        UserTabView()
    }
}
