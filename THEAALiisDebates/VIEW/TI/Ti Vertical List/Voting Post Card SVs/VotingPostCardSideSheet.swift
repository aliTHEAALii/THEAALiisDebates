//
//  VotingPostCardSideSheet.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 7/3/24.
//

import SwiftUI

struct VotingPostCardSideSheet: View {
    
    let isAdmin: Bool
    
    @Binding var ti: TI?
    @Binding private var tiChain: [String]
    @Binding private var selectedChainLinkIndex: Int
    @Binding private var tiChainLink: ChainLink?
    @Binding var vlPost: Post?
    
    
    @ObservedObject var cardVM = VotingCardViewModel()
    @Binding var showSideSheet: Bool
    @Binding var isLoading: Bool
    
    var body: some View {
        
        ZStack {
            
            // - Black Background
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.black)
                .frame(width: width * 0.35, height: width * 0.5625 * 0.85)
            
            
            // - Border
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(lineWidth: 0.2)
                .foregroundColor(.primary)
                .frame(width: width * 0.35, height: width * 0.5625 * 0.85)
            
            
            
            HStack(spacing: 0) {
                
                
                //MARK: - Left Column
                VStack(spacing: 0) {
                    
                    // - top (Add Post to Chain )
                    Button {
                        if isAdmin {
                            vlPostToChain()
                        }
                    } label: {
                        if isAdmin {
                            
                            VStack(spacing: 0) {
                                
                                ZStack {
                                    TiTriangle(scale: 0.15, stroke: 3, color: Color.ADColors.green)
                                        .offset(x: width * 0.01)
                                    TiTriangle(scale: 0.15, stroke: 3, color: Color.ADColors.green)
                                        .offset(x: width * -0.01)
                                }
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.25)
                                
                                
                                Text("Add to Chain")
                                    .font(.system(size: width * 0.02, weight: .regular))
                            }
                            .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        } else {
                            Image(systemName: "circle")
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        }
                        
                    }
                    
                    
                    if isAdmin {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        
                    } else {
                        // - middle
                        Button {
                            
                        } label: {
                            
                            Image(systemName: "circle")
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        }
                    }
                    
                    // - bottom
                    Button {
                        
                    } label: {
                        if isAdmin {
                            VStack(spacing: 0) {
                                Image(systemName: "xmark.square")
                                    .foregroundStyle(.red)
                                    .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.15)
                                
                                Text("Delete Post")
                                    .font(.system(size: width * 0.02, weight: .regular))
                                
                            }
                            .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                            
                        } else {
                            Image(systemName: "circle")
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        }
                    }
                    
                }
                .frame(width: width * 0.15, height: width * 0.5625 * 0.85)
                
                //MARK: - Right Column
                VStack(spacing: 0) {
                    
                    // -
                    Button {
                        
                    } label: {
                        Image(systemName: "circle")
                            .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        
                    }
                    
                    // - collapse button
                    Button {
                        withAnimation(.spring()) {
                            showSideSheet.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title)
                            .fontWeight(.thin)
                            .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        
                    }
                    
                    // -
                    Button {
                        
                    } label: {
                        Image(systemName: "circle")
                            .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                        
                    }
                    
                }
                .frame(width: width * 0.15, height: width * 0.15)
                
            }
            .foregroundColor(.primary)
            .frame(width: width * 0.35, height: width * 0.5625 * 0.85, alignment: .leading)
        }
    }
    
    //MARK: - Add Post to Chain
    func vlPostToChain() {
        if isAdmin {
            guard let ti, let tiChainLink, let vlPost else { print("❌ VLPost Side Sheet Error ❌"); return }
            isLoading = true
            
            let chainLink = ChainLink(id: vlPost.id, title: vlPost.title, thumbnailURL: vlPost.imageURL)
            let leftOrRight: LeftOrRight = ti.rightSideChain.contains(tiChainLink.id) ? .right : .left
            
            Task {
                do {
                    do {
                        try await PostManager.shared.createPost(tiID: ti.id, post: vlPost)
                    } catch {
                        print("🆘Error in createPost: \(error)❣️")
                        throw error
                    }
                    
                    do {
                        try await ChainLinkManager.shared.createChainLink(tiID: ti.id, chainLink: chainLink)
                    } catch {
                        print("🆘Error in createChainLink: \(error)❣️")
                        throw error
                    }
                    
                    do {
                        try await TIManager.shared.addToChain(tiID: ti.id, cLinkID: vlPost.id, rightOrLeft: leftOrRight)
                    } catch {
                        print("🆘Error in addToChain: \(error)❣️")
                        throw error
                    }
                    
                    do {
                        try await PostManager.shared.updateAddToChain(tiID: ti.id, chainLinkID: tiChainLink.id, postID: vlPost.id)
                    } catch {
                        print("🆘Error in updateAddToChain: \(error)❣️")
                        throw error
                    }
                    
                    isLoading = false // Ensure isLoading is set to false after all operations are complete
                } catch {
                    print("🆘⛓️❣️ VL Post Error: Couldn't upload vl Post to Ti Chain ❣️⛓️🆘")
                    isLoading = false // Ensure isLoading is set to false in case of error
                    return
                }
            }
        }
    }


    
}

#Preview {
    TiView(ti: nil, showTiView: .constant(true))

//    VotingPostCardSideSheet(isAdmin: true, showSideSheet: .constant(true))
}
