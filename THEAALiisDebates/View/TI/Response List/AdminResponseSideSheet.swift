//
//  AdminResponseSideSheet.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/14/23.
//

import SwiftUI

struct AdminResponseSideSheet: View {
    
    let tiId: String
    let tiChainLId: String
    let tiVideo: TIVideoModel
    let isAdmin: Bool
    @ObservedObject private var cardVM = VotingCardViewModel()
    @Binding var showSideSheet: Bool
    
    var body: some View {
        
        
        HStack(spacing: 1) {
            AdminOptions(tiId: tiId, tiChainLId: tiChainLId, tiVideo: tiVideo, isAdmin: isAdmin)
            ZStack {
                
                // - Black Background
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                //                    .frame(width: width * 0.35, height: width * 0.45, alignment: .leading)
                    .frame(width: width * 0.35, height: width * 0.5625 * 0.85)
                
                
                // - Border
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 0.2)
                    .foregroundColor(.primary)
                //                    .frame(width: width * 0.35, height: width * 0.45, alignment: .leading)
                    .frame(width: width * 0.35, height: width * 0.5625 * 0.85)
                
                
                
                HStack(spacing: 0) {
                    
                    
                    //MARK: - Left Column
                    VStack(spacing: 0) {
                        
                        // -
                        Button {
                            
                        } label: {
                            Image(systemName: "circle")
                            //                                .frame(width: width * 0.15, height: width * 0.15)
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                            
                        }
                        
                        // -
                        Button {
                            
                        } label: {
                            Image(systemName: "circle")
                            //                                .frame(width: width * 0.15, height: width * 0.15)
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                            
                        }
                        
                        // -
                        // -
                        Button {
                            
                        } label: {
                            Image(systemName: "circle")
                            //                                .frame(width: width * 0.15, height: width * 0.15)
                                .frame(width: width * 0.15, height: width * 0.5625 * 0.85 * 0.33)
                            
                        }
                        
                    }
                    .frame(width: width * 0.15, height: width * 0.5625 * 0.85)
                    
                    //MARK: - Right Column
                    VStack(spacing: 0) {
                        
                        // -
                        Button {
                            
                        } label: {
                            Image(systemName: "circle")
                            //                                .frame(width: width * 0.15, height: width * 0.15)
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
                            //                                .frame(width: width * 0.15, height: width * 0.15)
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
    }
}

struct AdminResponseSideSheet_Previews: PreviewProvider {
    static var previews: some View {
        AdminResponseSideSheet(tiId: "id", tiChainLId: "cid", tiVideo: TestingComponents().titVideo, isAdmin: true, showSideSheet: .constant(true))
            .preferredColorScheme(.dark)
        
        AdminOptions(tiId: "whatever", tiChainLId: "cid", tiVideo: TestingComponents().titVideo, isAdmin: true)
            .preferredColorScheme(.dark)
    }
}



//MARK: Admin Options
struct AdminOptions: View {
    
    let tiId: String
    let tiChainLId: String
    let tiVideo: TIVideoModel
    let  isAdmin: Bool
    @ObservedObject private var vmCard = VotingCardViewModel()
    
    var body: some View {
        
        
        ZStack {
            
            // - Black Background
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.black)
                .frame(width: width * 0.2, height: width * 0.5625 * 0.85, alignment: .leading)
            
            
            // - Border
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(lineWidth: 0.2)
                .foregroundColor(.primary)
                .frame(width: width * 0.2, height: width * 0.5625 * 0.85, alignment: .leading)
            
            
            
            VStack(spacing: 0) {
                
                //MARK: Add Video to Chain
                Button {
                    //                    if isAdmin { cardVM.addTiVideoToTiChain(tiId: , tiVideoId: <#T##String#>) }
                    if isAdmin {
                        Task {
                            try await vmCard.addTiVideoToTiChain(tiId: tiId, tiVideo: tiVideo)
                        }
                    }
                } label: {
                    VStack(spacing: width * 0.015) {
                        
                        AddButtonSV()
                            .frame(height: width * 0.11)
                        
                        Text("add to T.I. Chain")
                            .font(.system(size: width * 0.035, weight: .light))
                    }
                    .foregroundColor(.secondary)
                    .frame(height: width * 0.5625 * 0.85 * 0.63)
                }
                
                Divider()
                
                //MARK:  Delete Video
                Button {
                    if isAdmin {
                        Task {
                            try await vmCard.deleteTIVideoInRSList(tiId: tiId, tiChainLId: tiChainLId, tiVideoId: tiVideo.id, tiVideoThumbnailId: tiVideo.thumbnail)
                        }
                    }
                } label: {
                    VStack(spacing: width * 0.015) {
                        Image(systemName: "xmark")
                            .font(.system(size: width * 0.07, weight: .light))
                        
                        Text("Delete")
                    }
                    .foregroundColor(.secondary)
                    .frame(height: width * 0.5625 * 0.85 * 0.37)
                    
                }
            }
            .frame(width: width * 0.2, height: width * 0.5625 * 0.85)
        }
    }
}
