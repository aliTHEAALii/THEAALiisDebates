//
//  TIIcon.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 8/1/23.
//

import SwiftUI

struct TIIcon: View {
    
    var scale: CGFloat = 1
    var rotationDegree: CGFloat = 180
    var timeLapseWeight: Font.Weight = .thin
    var triangleWeight:  Font.Weight = .light

    
    var body: some View {
        
        ZStack {
            Group {
                Circle()
                    .fill(Color.black)
                Circle()
                    .stroke(lineWidth: 0.7 * scale)
            }
            .frame(width: width * 0.2 * scale)

            
            Image(systemName: "timelapse")
                .foregroundColor(.gray)
                .font(.system(size: width * 0.16 * scale, weight: timeLapseWeight))
            
            Image(systemName: "triangle")
                .foregroundColor(.ADColors.green)
                .font(.system(size: width * 0.06 * scale, weight: triangleWeight))
                .offset(y: -3)
                .rotationEffect(.degrees(rotationDegree))
        }
        .foregroundColor(.primary)
        .preferredColorScheme(.dark)
    }
}

struct TIIcon_Previews: PreviewProvider {
    static var previews: some View {
//        TIIcon()
//        TIIconD2()
        CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(2), indexStep: 1)

    }
}


struct TIIconD1: View {
    
    var scale: CGFloat = 1
    var rotationDegree: CGFloat = 180
    var timeLapseWeight: Font.Weight = .thin
    var triangleWeight:  Font.Weight = .light

    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            //Border
            RoundedRectangle(cornerRadius: 8 * scale)
                .trim(from: 0, to: 0.5)
                .stroke(lineWidth: 1 * scale)
                .offset(y: width * -0.03)
                .frame(width: width * 0.66 * scale, height: width * 0.15 * scale)
                .foregroundColor(.primary)
            
            TIIcon(scale: scale, rotationDegree: rotationDegree, timeLapseWeight: timeLapseWeight, triangleWeight: triangleWeight)
                .offset(x: width * -0.1 * scale)
        }
    }
}


struct TIIconD2: View {
    
    var scale: CGFloat = 1
    var rotationDegree: CGFloat = 180
    var timeLapseWeight: Font.Weight = .thin
    var triangleWeight:  Font.Weight = .light

    var showTwoSides = true
    
    var body: some View {
        
        ZStack {
            
            //Border
            RoundedRectangle(cornerRadius: 8 * scale)
                .trim(from: 0, to: 0.5)
                .stroke(lineWidth: 1 * scale)
                .offset(y: width * -0.03 *  scale)
                .frame(width: width * 0.7 * scale, height: width * 0.15 * scale)
                .foregroundColor(.primary)
            
            TIIcon(scale: scale, rotationDegree: rotationDegree, timeLapseWeight: timeLapseWeight, triangleWeight: triangleWeight)
            
            //MARK: - Left & Right Users
            if showTwoSides {
                HStack {
                    
                    ZStack {
                        Circle()
                            .frame(width: width * 0.1 * scale)
                            .padding(.leading, width * 0.01 * scale)
                        Circle()
                            .stroke(lineWidth: 2 * scale)
                            .frame(width: width * 0.1 * scale)
                            .padding(.leading, width * 0.01 * scale)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .frame(width: width * 0.1 * scale)
                            .padding(.leading, width * 0.01 * scale)
                        Circle()
                            .stroke(lineWidth: 2 * scale)
                            .frame(width: width * 0.1 * scale)
                            .padding(.trailing, width * 0.01 * scale)
                    }
                }
                .frame(width: width * scale, height: width * 0.15 * scale)
            }
        }
    }
}
