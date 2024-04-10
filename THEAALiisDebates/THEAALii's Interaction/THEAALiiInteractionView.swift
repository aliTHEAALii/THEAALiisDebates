//
//  THEAALiiInteraction.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/30/23.
//

import SwiftUI

struct THEAALiiInteractionView: View {
    
    @State var ti: TI = TestingComponents().testTI0
    
    @State private var tiCLink: TITChainLinkModel? = nil
    @State private var tiVideo: TIVideoModel? = nil

    @State private var rightIndex: Int? = nil
    @State private var leftIndex : Int? = nil
    
    @State private var expandTIControls: Bool = true
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // - Video
            VideoSV(urlString: tiVideo?.videoURL ?? "")
            
            // - Control Center
            if ti.tiType == .d2 {
                TIvsControlCenter(ti: $ti, rightIndex: $rightIndex, leftIndex: $leftIndex)
            } else if ti.tiType == .d1 {
                ///
            } else if ti.tiType == .post {
                ///
            }
            
            Spacer()
        }// - VStack - //
        .preferredColorScheme(.dark)
    }
    
    //Functions
//    private func fetch
}

struct THEAALiiInteractionView_Previews: PreviewProvider {
    static var previews: some View {
        THEAALiiInteractionView()
    }
}

