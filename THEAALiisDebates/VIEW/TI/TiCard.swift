//
//  TiCard.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 7/7/24.
//

import SwiftUI

struct TiCard2: View {
    
    var body: some View {
        
        GeometryReader { geometry in
            
            Button {
                
            } label: {
                
                VStack(spacing: 0) {
                    
                    // Thumbnail
                    VStack(spacing: 0) {
//                        ThumbnailSV(urlSting: tit.thumbnailURLString, name: tit.name)
//                            .aspectRatio(16/9, contentMode: .fit)
//                            .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .frame(height: geometry.size.width * 0.08)
                            .foregroundColor(.clear)
                    }
                }
            }
        }
    }
}

#Preview {
    TiCard2()
}
