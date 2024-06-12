//
//  VsIndicators.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 8/1/23.
//

import SwiftUI


//MARK: - VS Indicators
struct VsIndicatorsTopBar: View {
    
    @Binding var ti: TI
    @Binding var rightIndex: Int?
    @Binding var leftIndex: Int?
    
    @Binding var expandTiControls: Bool
    
    var body: some View {
        
        Button {
            expandTiControls.toggle()
        } label: {
            
            ZStack {
                //
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.96, height:width * 0.08)
                
                HStack(spacing: width * 0.01) {
                    
        
                    //MARK: left
                    
                    Button { } label: {
                        Image(systemName: "triangle")
                            .rotationEffect(.degrees(270))
                            .frame(width: width * 0.05)
                    }

                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<(ti.leftSideChain?.count ?? 0), id: \.self) { i in
                                if leftIndex == i {
                                    Image(systemName: "triangle")
                                        .foregroundColor(.ADColors.green)
                                        .font(.system(size: width * 0.05, weight: .regular))
                                } else {
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(.gray)
                                            .frame(width: width * 0.05)
                                        Text("\(i + 1)")
                                            .flipsForRightToLeftLayoutDirection(true)
                                            .environment(\.layoutDirection, .rightToLeft)
                                    }
                                }
                            }
                        }
                    }
//                    .frame(width: width * 0.41)
                    .frame(width: width * 0.36)
                    .flipsForRightToLeftLayoutDirection(true)
                    .environment(\.layoutDirection, .rightToLeft)
                    
                    
                    //MARK: Center
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: width * 0.12)
                        Circle()
                            .stroke(lineWidth: 0.7)
                            .frame(width: width * 0.12)
                        
                        Image(systemName: "timelapse")
                            .foregroundColor(.gray)
                            .font(.system(size: width * 0.1, weight: .light))
                        
                        if rightIndex == nil && leftIndex == nil {
                            Image(systemName: "triangle")
                                .foregroundColor(.ADColors.green)
                                .font(.system(size: width * 0.03, weight: .light))
                                .offset(y: -1)                                            .rotationEffect(.degrees(180))
                        }
                    }
                    .foregroundColor(.primary)
                    
                    
                    //MARK: Right
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<ti.rightSideChain.count, id: \.self) { i in
                                if rightIndex == i {
                                    Image(systemName: "triangle")
                                        .foregroundColor(.ADColors.green)
                                        .font(.system(size: width * 0.05, weight: .regular))
                                } else {
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .frame(width: width * 0.05)
                                        Text("\(i + 1)")
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: width * 0.41)
                }
                .foregroundColor(.primary)
                .frame(width: width * 0.96, height: width * 0.14)
            }// - Scroll - //
            .frame(width: width * 0.96, height: width * 0.14)
        }
    }
}

struct VsIndicators_Previews: PreviewProvider {
    static var previews: some View {
        THEAALiiInteractionView()
    }
}
