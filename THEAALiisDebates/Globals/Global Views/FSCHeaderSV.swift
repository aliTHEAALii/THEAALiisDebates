//
//  FSCHeaderSV.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/14/24.
//

import SwiftUI

struct FSCHeaderSV: View {
    
    @Binding var showFSC: Bool
    let text: String
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            Text(text)
                .font(.title)
                .frame(width: width * 0.85, height: width * 0.15, alignment: .leading)
            CloseButton(showFSC: $showFSC)
        }
    }
}

#Preview {
    FSCHeaderSV(showFSC: .constant(true), text: "Header Here")
}
