//
//  CCAddToChainButton.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 6/18/24.
//

import SwiftUI

struct CCAddToChainButton: View {
    let rightOrLeft: LeftOrRight?
    
    @Binding var ti: TI?
    @Binding var tiChainLink: ChainLink?
    @Binding var tiChain: [String]
    
    @State private var showCreatePost: Bool = false
    
    var body: some View {
        
        VStack {
            Button{
                showCreatePost = true
            } label: {
                AddButtonSV()
            }
            .fullScreenCover(isPresented: $showCreatePost) {
                CCAddToChain(leftOrRight: rightOrLeft, ti: $ti, tiChainLink: $tiChainLink, tiChain: $tiChain, showAddPostFSC: $showCreatePost)
            }
            
        }
        
    }
}

#Preview {
    CCAddToChainButton(rightOrLeft: .right, ti: .constant(TestingModels().testTI0), tiChainLink: .constant(nil), tiChain: .constant(["ii"]))
}
