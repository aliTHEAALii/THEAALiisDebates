//
//  VerticalListView.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 6/27/24.
//

import SwiftUI


struct TiVerticalListView: View {
    
    @Binding var ti: TI?
    @Binding var tiChain: [String]
    @Binding var tiChainLink: ChainLink?
    @Binding var tiPost: Post?
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            Divider()
            
            HStack(spacing: 0) {
                
                Spacer()
                
                Text("Vertical")
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.3)
                
                Spacer()
                
                //MARK: Add Video to list
                CCAddToChainButton(rightOrLeft: nil, ti: $ti, tiChainLink: $tiChainLink, tiChain: $tiChain)
                
                Spacer()
                
                Text("List")
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.3)
                
                
                Spacer()
                
            }
            .padding(.vertical)
            
            if let verticalList = tiChainLink?.verticalList {
                
                //ForEach(Array(zip(verticalList.indices, verticalList)), id: \.0) { index, postID in
                ForEach(Array(verticalList.enumerated()), id: \.element) { index, postID in
                    
                    //                    VotingPostCard(postID: postID, ti: $ti, chainLink: $tiChainLink, 
                    //                                   tiPostID: postID,
                    //                                   order: index + 1, isAdmin: true)
                    //                            }
                    VotingPostCard(postID: postID, 
                                   ti: $ti,
                                   chainLink: $tiChainLink,
                                   tiPostID: postID,
                                   order: index + 1, 
                                   isAdmin: true)
                }
            }
        }
    }
}

#Preview {
    TiView(ti: nil, showTiView: .constant(true))

//    VerticalListView(ti: .constant(nil), tiChain: .constant([]), tiChainLink: .constant(nil), tiPost: .constant(nil))
}

