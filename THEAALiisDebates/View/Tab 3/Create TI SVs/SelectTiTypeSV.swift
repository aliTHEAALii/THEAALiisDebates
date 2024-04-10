//
//  SelectTiTypeSV.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/7/24.
//

import SwiftUI

struct SelectTiTypeSV: View {
    
    @Binding var tiInteractionType: TIType?
    
    var body: some View {
        VStack(spacing: width * 0.1) {
            
            Button {
                tiInteractionType = .d1
            } label: {
                ZStack {
                    VStack {
                        
                        D1Icon(sf: 0.6)
                            .foregroundStyle(.primary, .primary)
                        
                        
                        Text("Mono Directional (D1)")
                            .foregroundStyle(tiInteractionType == .d1 ? Color.ADColors.green : .primary)
                    }
                    if tiInteractionType == .d1 {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color.ADColors.green)
                            .frame(width: width * 0.95, height: width * 0.5)
                    }
                }
            }
            
            
            
            Button {
                tiInteractionType = .d2
            } label: {
                ZStack {
                    VStack {
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(lineWidth: 1.0)
//                            .frame(width: width * 0.75, height: width * 0.4)
                        D2Icon(sf: 0.6)
                        
                        
                        
                        Text("Bi Directional (D2)")
                            .foregroundStyle(tiInteractionType == .d2 ? Color.ADColors.green : .primary)
                    }
                    if tiInteractionType == .d2 {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color.ADColors.green)
                            .frame(width: width * 0.95, height: width * 0.5)
                    }
                }
            }
        }
    }
}


#Preview {
    CreateTI(showFSC: .constant(false), selectedTabIndex: .constant(0))
//    SelectTiTypeSV(tiInteractionType: .constant(.d1))
}
