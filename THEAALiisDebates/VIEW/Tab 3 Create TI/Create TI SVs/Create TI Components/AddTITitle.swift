//
//  AddTITitle.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/29/24.
//

import SwiftUI

//MARK: - Add TIT Title
struct AddTITitle: View {
    
    @Binding var tiTitle: String

    
    var body: some View {
        HStack(spacing: 10) {
            
            
            //MARK: Title
            ZStack {
                //Border
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(tiTitle != "" ? .primary : .red)
                    .frame(width: width * 0.9, height: width * 0.2)
                
                if tiTitle == "" {
                    Text("TI Title")
                }
                
                TextField("", text: $tiTitle, axis: .vertical)
                    .multilineTextAlignment(.center)
                    .frame(width: width * 0.9, height: width * 0.1, alignment: .center)
                    .submitLabel(.done)
            }
        }
    }
}

#Preview {
//    AddTITitle()
    
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)

}
