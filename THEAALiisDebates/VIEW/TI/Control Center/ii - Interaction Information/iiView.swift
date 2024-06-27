//
//  iiView.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 6/19/24.
//

import SwiftUI

struct iiView: View {
    
    @Binding var ti: TI
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.gray)
                    .frame(width: width * 0.9, height: width * 0.08)

                HStack {
                    UserButton(userUID: nil)
                    Spacer()
                    TIIcon()
                    Spacer()
                    UserButton(userUID: nil)
                }
            }
            
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    iiView(ti: .constant(TestingModels().testTI0))
}
