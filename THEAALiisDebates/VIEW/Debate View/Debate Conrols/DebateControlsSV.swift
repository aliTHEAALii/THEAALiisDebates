//
//  DebateControlsSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/22/23.
//

import SwiftUI

struct DebateControlsSV: View {
    
    
    
    @State private var showAllDebateControls = false
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            // - Outer border
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(lineWidth: 0.5)
                .foregroundColor(.secondary)
                .frame(width: width,
                       height: showAllDebateControls ? width * 0.7 : width * 0.15)//
            
            
            VStack(spacing: 0) {
                
                // - height: width * 0.15
                HStack(spacing: 0) {
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "triangle")
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: width * 0.15, height: width * 0.15)
                        
                    }
                    
                    Spacer()
                    
                    // - Debate Indicators
                    Button {
                        withAnimation {
                            showAllDebateControls.toggle()
                        }
                    } label: {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .foregroundColor(.secondary)
                            .frame(width: width * 0.5, height: width * 0.1)
                    }
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "triangle")
                            .rotationEffect(Angle(degrees: 90))
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                    
                }
                .foregroundColor(.primary)
                
                //MARK: - All Controls
                if showAllDebateControls {
                    
                    DebateControlsExpandedSV()
                }
                
            }//VStack
            .frame(height: showAllDebateControls ? width * 0.5 : width * 0.15, alignment: .top)
        }
        .background(Color.black)
    }
}

struct DebateControlsSV_Previews: PreviewProvider {
    static var previews: some View {
        
//        TabsBarCustomized(isMiniPlayer: false)
//        TITView(TIT: TestingComponents().testingTIT, showDebateView: .constant(true), isMiniPlayer : .constant(false))

        DebateControlsSV()
            .preferredColorScheme(.dark)
    }
}

//MARK: - DebateControlsExpandedSV
struct DebateControlsExpandedSV: View {
    var body: some View {
        VStack(spacing: 0) {
            // - Debate Map (0.35)
            TITMap()
            
            
            HStack(spacing: 0) {
                
                Button {
                    
                } label: {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .foregroundColor(.secondary)
                            .frame(width: width * 0.12, height: width * 0.12)
                        
                        //                                Image(systemName: "plus")
                        //                                    .font(.system(size: width * 0.08, weight: .light))
                        //                                    .foregroundColor(.primary)
                        Image(systemName: "plus")
                            .font(.system(size: width * 0.075, weight: .thin))
                            .frame(width: width * 0.1)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.all)
                
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .foregroundColor(.secondary)
                            .frame(width: width * 0.3, height: width * 0.12)
                        
                        Text("Debate Info")
                            .font(.title2)
                            .fontWeight(.light)
                            .foregroundColor(.ADColors.green)
                    }
                }
                .padding(.all)
                
            }
            .frame(width: width, height: width * 0.2)
        }
    }
}

//MARK: - TIT Map
struct TITMap: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<5, id: \.self) { i in
                    VStack(spacing: 0) {
                        
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(.gray)
                            .frame(width: width * 0.25, height: width * 0.5625 * 0.25)
                        
                        Text("Video title goes here and it's a long title. yes that's bad")
                            .font(.caption)
                            .frame(width: width * 0.25, height: width * 0.5625 * 0.25)
                        
                    }
                }
            }
            //                        .frame(height: width * 0.35)
        }
        .frame(height: width * 0.35)
    }
}
