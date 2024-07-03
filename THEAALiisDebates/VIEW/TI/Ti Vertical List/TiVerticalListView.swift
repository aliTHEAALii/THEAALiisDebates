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
                .padding(.bottom)
            
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
            
            if let verticalList = tiChainLink?.verticalList {
                ForEach(verticalList, id: \.self) { postID in
                    
                    VotingPostCard(postID: postID, ti: $ti, chainLink: $tiChainLink, tiVideoID: postID, order: 0, isAdmin: true)
                }
            }
        }
    }
}

#Preview {
    TiView(ti: nil, showTiView: .constant(true))

//    VerticalListView(ti: .constant(nil), tiChain: .constant([]), tiChainLink: .constant(nil), tiPost: .constant(nil))
}

//MARK: - Voting Video Card
struct VotingPostCard: View {
    
    @AppStorage("current_user_id") private var currentUserId: String = ""

    let postID: String?
    
    @Binding var ti: TI?
    @Binding var chainLink: ChainLink?
    @State var tiPost: Post? = nil
    let tiVideoID: String
    @State var tiVideo: TIVideoModel? = nil
    let order: Int
    
    let isAdmin: Bool

    
//    @StateObject private var cardVM = VotingCardViewModel()
    @State private var showSideOptions: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack {
                HStack(spacing: 0) {
                    
                    //MARK: Video
                    ZStack(alignment: .topLeading) {
                        if tiPost != nil {
                            TIVideoPlayerSV(tiVideo: $tiVideo, urlString: "", sf: 0.85)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                            LoadingView() }
                        Text("\(order)")
                            .padding(.all, width * 0.02)
                    }
                    
                    Divider()
                    
                    //MARK: - Voting
                    if tiVideo != nil, ti != nil {
                        VotingSV(tiId: ti!.id, tiVideo: $tiVideo, showSideOptions: $showSideOptions)
                    } else {
                        ProgressView()
                            .frame(width: width * 0.15, height: width * 0.45)
                    }
                }
                .frame(width: width, alignment: .leading)
                
                
                //MARK: Side Options                SideOptionsSheet(showSideSheet: $showSideOptions)
                if isAdmin && tiVideo != nil, ti != nil, chainLink != nil {
                    AdminResponseSideSheet(tiId: ti!.id, tiChainLId: chainLink!.id, tiVideo: tiVideo!,
                                           isAdmin: isAdmin,
                                           showSideSheet: $showSideOptions)
                        .offset(x: showSideOptions ? width * 0.275 : width * 0.777)
                } else {
                    SideSheetForVotingCell(isAdmin: isAdmin, showSideSheet: $showSideOptions)
                        .offset(x: showSideOptions ? width * 0.375 : width * 0.68)
                }
            }
            .frame(height: width * 0.5625 * 0.85)
            
            //MARK: Post title
            Text(tiPost?.title ?? "No Name detected for TI Video")
                .foregroundColor(tiVideo?.name != nil ? .primary : .secondary)
                .frame(width: width * 0.95, height: width * 0.15)
            
            
            Divider()
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
//        .onAppear{ Task { try await onAppearFetchTIVideo() } }
        .onAppear{ onAppearFetchPost() }
    }
    
    //MARK: - Fetch ☕️ Video
//    func onAppearFetchTIVideo() async throws {
//        do {
//            tiVideo = try await TITVideoManager.shared.getTITVideo(TITid: tiID, TITVideoID: tiVideoID)
//        } catch {
//            
//        }
//    }
    func onAppearFetchPost() {
        guard let ti else { return }
        guard let postID else { return }
        PostManager.shared.getPost(tiID: ti.id, postID: postID) { result in
            switch result{
            case .success(let post):
                tiPost = post
            case .failure(_): //error
                tiPost = nil
            }
        }
    }
    
//    @ViewBuilder
//    func votingSV() -> some View {
//        //MARK: - Voting
//        VStack(spacing: 0) {
//
//            Button {
//
//            } label: {
//                Image(systemName: "chevron.up")
//                    .foregroundColor(.secondary)
//                    .font(.title)
//                    .frame(width: width * 0.15, height: width * 0.15)
//            }
//
//            Button {
//                withAnimation(.spring()) {
//                    showSideOptions.toggle()
//                }
//            } label: {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 8)
//                        .strokeBorder(lineWidth: 0.5)
//                        .frame(width: width * 0.13, height: width * 0.1)
//
//                    //                                Text("4.6K")
//
//                    if let tiVideo = tiVideo {
//                        Text( String(tiVideo.upVotes - tiVideo.downVotes) )
//                            .fontWeight(.light)
//                    }
//                }
//                .foregroundColor(.primary)
//                .frame(width: width * 0.15, height: width * 0.15)
//            }
//
//
//            Button {
//
//            } label: {
//                Image(systemName: "chevron.down")
//                    .foregroundColor(.secondary)
//                    .font(.title)
//                    .frame(width: width * 0.15, height: width * 0.15)
//            }
//
//        }
//    }
}
