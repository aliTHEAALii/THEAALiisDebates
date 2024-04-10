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
            ZStack {

    //            RoundedRectangle(cornerRadius: 10)
    //                .frame(width: width * 0.1, height: width * 0.1)
    //                .foregroundColor(.black)
    //
    //            RoundedRectangle(cornerRadius: 10)
    //                .strokeBorder(lineWidth: 0.7)
    //                .frame(width: width * 0.1, height: width * 0.1)
    //                .foregroundColor(.white)

                Image(systemName: "xmark")
                    .font(.system(size: width * 0.075, weight: .thin))
                    .foregroundColor(.primary)
            }
//            .padding(.trailing)
        }
        .preferredColorScheme(.dark)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(showFSC: .constant(true))
    }
}
