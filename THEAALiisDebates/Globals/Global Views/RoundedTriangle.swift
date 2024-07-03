//
//  RoundedTriangle.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 5/24/24.
//

import SwiftUI

struct RoundedTriangle: Shape {
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        // The triangle's three corners.
        let bottomLeft = CGPoint(x: 0, y: height)
        let bottomRight = CGPoint(x: width, y: height)
        let topMiddle = CGPoint(x: rect.midX, y: 0)
        
        // We'll start drawing from the bottom middle of the triangle,
        // the midpoint between the two lower corners.
        let bottomMiddle = CGPoint(x: rect.midX, y: height)
        
        // Draw three arcs to trace the triangle.
        var path = Path()
        path.move(to: bottomMiddle)
        path.addArc(tangent1End: bottomRight, tangent2End: topMiddle, radius: cornerRadius)
        path.addArc(tangent1End: topMiddle, tangent2End: bottomLeft, radius: cornerRadius)
        path.addArc(tangent1End: bottomLeft, tangent2End: bottomMiddle, radius: cornerRadius)
        path.addLine(to: bottomMiddle)
        
        
        return path
    }
}

#Preview {

    TiTriangle(scale: 1)
//    RoundedTriangle(cornerRadius: 15)
//        .stroke(lineWidth: 1)
//        .frame(width: width * 0.5 , height: width * 0.5)
}

struct TiTriangle: View {
    
    var scale: CGFloat = 1
    var stroke: CGFloat = 1
    var color: Color = .white
    var fill = false
    var upsideDown = false
    
    var body: some View {
        
        ZStack {
            
//            Image(systemName: "triangle")
//                .font(.system(size: width * 0.5, weight: .thin))
//                .frame(width: width * 0.5 * scale, height: width * 0.5 * scale)
//                .offset(y: 20)
            
            if fill {
                RoundedTriangle(cornerRadius: 16 * scale)
                    .foregroundStyle(color)
                    .frame(width: width * 0.5 * scale, height: width * 0.5 * scale)
                    .rotationEffect(.degrees(upsideDown ? 180 : 0))
                
            } else {
                RoundedTriangle(cornerRadius: 16 * scale)
                    .stroke(lineWidth: stroke * scale)
                    .foregroundStyle(color)
                    .frame(width: width * 0.55 * scale, height: width * 0.5 * scale)
                    .rotationEffect(.degrees(upsideDown ? 180 : 0))
                
            }
            
            
            
        }
    }
}
