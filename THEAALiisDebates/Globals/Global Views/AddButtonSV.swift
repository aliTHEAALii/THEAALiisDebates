//
//  AddButtonSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/15/23.
//

import SwiftUI

struct AddButtonSV: View {
    var body: some View {
        
//        Button{ 
//            
//        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.10, height: width * 0.10)
                
                Image(systemName: "plus")
                    .font(.system(size: width * 0.075, weight: .thin))
                    .frame(width: width * 0.1)
                    .foregroundColor(.primary)
            }
            .frame(width: width * 0.15)
            .preferredColorScheme(.dark)
//        }
        
        
    }
}

struct AddButtonSV_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonSV()
    }
}
