//
//  D1Icon.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/10/24.
//

import SwiftUI

struct D1Icon: View {
    
    var sf: CGFloat = 1

    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            //FIXME: Debate Chains Count
//            DebateCardIndicatorCirclesSV(debateChainsCount: 1)
//            
//            //Border
//            RoundedRectangle(cornerRadius: 8)
//                .trim(from: 0, to: 0.5)
//                .stroke(lineWidth: 1)
//                .frame(width: width * 0.45, height: width * 0.15)
//                .foregroundColor(.primary)

            
            VStack(spacing: 0) {
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1 * sf)
                    .foregroundStyle(.white, .white)
                    .frame(width: width * sf, height: width * 0.5625 * sf)
                
                Spacer()
            }
            
//            TIIcon(scale:0.7)
//                .offset(x: -width * 0.25, y: width * 0.03)
            
            TIIconD1(scale: 0.8 * sf)
        }
        .frame(width: width * sf, height: width * 0.68 * sf)

    }
}

#Preview {
    D2Icon()
}


struct D2Icon: View {
    
    var sf: CGFloat = 1

    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            //FIXME: Debate Chains Count
//            DebateCardIndicatorCirclesSV(debateChainsCount: 1)
//
//            //Border
//            RoundedRectangle(cornerRadius: 8)
//                .trim(from: 0, to: 0.5)
//                .stroke(lineWidth: 1)
//                .frame(width: width * 0.45, height: width * 0.15)
//                .foregroundColor(.primary)

            
            VStack(spacing: 0) {
                
                RoundedRectangle(cornerRadius: 8 * sf)
                    .stroke(lineWidth: 1 * sf)
                    .foregroundStyle(.white, .white)
                    .frame(width: width * sf, height: width * 0.5625 * sf)
                
                Spacer()
            }
            
//            TIIcon(scale:0.7)
//                .offset(x: -width * 0.25, y: width * 0.03)
            
            TIIconD2(scale: 0.8 * sf)
        }
        .frame(width: width * sf, height: width * 0.68 * sf)

    }
}
