//
//  CCBottomBar.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 7/13/24.
//

import SwiftUI

struct CCBottomBar: View {
    
    @Binding var ti: TI?
    @Binding var tiChain: [String]
    
    var body: some View {
        
        //MARK: - Control Center Bottom(interaction) Bar
        HStack(spacing:0) {
            
            //Left Side
            if ti?.tiType == .d2 {
                UserButton()
                    .frame(width: width * 0.2)      //u
                
                //                            AddButtonSV()   //width * 0.15
                if ti != nil {
                    CCAddToChainButton(rightOrLeft: .left, ti: $ti, tiChainLink: .constant(nil), tiChain: $tiChain)
                } else {
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(width: width * 0.15)
                }
            } else if ti?.tiType == .d1 {
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: width * 0.3)
            }
            
            
            //( Interaction Info ) Button
            iiButton(ti: $ti)
            
            //                            AddButtonSV()   //width * 0.15
            if ti != nil {
                CCAddToChainButton(rightOrLeft: .right, ti: $ti, tiChainLink: .constant(nil), tiChain: $tiChain)
            } else {
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: width * 0.15)
            }
            
            UserButton()
                .frame(width: width * 0.2)      //u
        }
        .frame(width: width, height: width * 0.25)
    }
}

#Preview {
//    CCBottomBar()
    
    TiView(ti: TestingModels().testTI1nil, showTiView: .constant(true))

}
