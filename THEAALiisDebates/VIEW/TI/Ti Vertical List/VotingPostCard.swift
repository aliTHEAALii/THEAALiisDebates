//
//  VotingPostCard.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 6/30/24.
//

import SwiftUI


//MARK: - Voting Video Card
struct VotingPostCard: View {
    
    @AppStorage("current_user_id") private var currentUserId: String = ""
    
    let postID: String?
    
    @Binding var ti: TI?
    @Binding var chainLink: ChainLink?
    @State var tiPost: Post? = nil
    let tiPostID: String
    @State var tiVideo: TIVideoModel? = nil
    let order: Int
    
    let isAdmin: Bool
    
    
    //    @StateObject private var cardVM = VotingCardViewModel()
    @State private var showSideOptions: Bool = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ZStack {
                HStack(spacing: 0) {
                    
                    //MARK: Content
                    ZStack(alignment: .topLeading) {
                        if tiPost != nil {
                            //                            TIVideoPlayerViewOld(tiVideo: $tiVideo, urlString: "", sf: 0.85)
                            VotingPostCardContent(post: $tiPost, sf: 0.85)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                            LoadingView()
                        }
                        
                        //Order Tag
                        Text("\(order)")
                            .padding(.all, width * 0.02)
                    }
                    
                    
                    
                    //MARK: - Voting
                    if ti != nil, tiPost != nil {
                        VotingButtonsSV(ti: $ti, vlPost: $tiPost, showSideOptions: $showSideOptions)
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
                    SideSheetForVotingCellOld(isAdmin: isAdmin, showSideSheet: $showSideOptions)
                        .offset(x: showSideOptions ? width * 0.375 : width * 0.68)
//                    VotingPostCardSideSheet(isAdmin: isAdmin, ti: $ti,
//                                            tiChain: ,
//                                            selectedChainLinkIndex: ,
//                                            tiChainLink: $chainLink, tiPost: $tiPost, showSideSheet: $showSideOptions)
                }
            }
            .frame(height: width * 0.5625 * 0.85)
            
            
            //MARK: Post title
            HStack {
                Text(tiPost?.title ?? "No Name detected for TI Video")
                    .foregroundColor(tiPost?.title != nil ? .primary : .secondary)
                    .padding(.leading)
                    .frame(height: width * 0.15)
                
                Spacer()
                
                UserButton(userUID: tiPost?.creatorUID, horizontalName: true, scale: 0.6)
                
            }
            
            
            Divider()
        }
        .background(Color.black)
        .preferredColorScheme(.dark)
        .onAppear{ onAppearFetchPost() }
    }
    
    
    //MARK: - Functions
    
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
    
}
#Preview {
    TiView(ti: nil, showTiView: .constant(true))
    
    //    VotingPostCard()
}


//MARK: - Voting Buttons SV
struct VotingButtonsSV: View {
    
    @AppStorage("current_user_id") private var currentUserUID: String = ""
    
    @Binding var ti: TI?
    @Binding var vlPost: Post?
    @State private var loadingUpVote = false
    @State private var loadingDownVote = false
    
    @Binding var showSideOptions: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Button {
                if !loadingUpVote {
                    upVote()
                }
                
            } label: {
                if let vlPost = vlPost {
                    if loadingUpVote {
                        ProgressView()
                            .frame(width: width * 0.15, height: width * 0.15)
                    } else {
                        Image(systemName: "chevron.up")
                            .foregroundColor(vlPost.upVotersUIDsArray.contains(currentUserUID) ? .ADColors.green : .secondary)
                            .font(.title)
                            .fontWeight(vlPost.upVotersUIDsArray.contains(currentUserUID) ? .heavy : .regular)
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                    
                }
            }
            
            //MARK: show options
            Button {
                withAnimation(.spring()) {
                    showSideOptions.toggle()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.13, height: width * 0.1)
                    
                    //Text("4.6K")
                    Text( String(vlPost!.totalVotes) )
                    //                    Text( String(totalVotes) )
                    
                    //                    Text( String(vlPost!.upVotes - vlPost!.downVotes) )
                        .fontWeight(.light)
                }
                .foregroundColor(.primary)
                .frame(width: width * 0.15, height: width * 0.15)
            }
            
            
            Button {
                if !loadingDownVote {
                    downVote()
                }
            } label: {
                if let vlPost = vlPost {
                    
                    if loadingDownVote {
                        ProgressView()
                            .frame(width: width * 0.15, height: width * 0.15)
                    } else {
                        Image(systemName: "chevron.down")
                            .foregroundColor(vlPost.downVotersUIDsArray.contains(currentUserUID) ? .red : .secondary)
                            .font(.title)
                            .fontWeight(vlPost.downVotersUIDsArray.contains(currentUserUID) ? .heavy : .regular)
                            .frame(width: width * 0.15, height: width * 0.15)
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
    
    
    //MARK: - UPVOTE func
    private func upVote() {
        loadingUpVote = true

        guard let tiID   = ti?.id else { loadingUpVote = false; return }
        guard let vlPost = vlPost else { loadingUpVote = false; return }
        
        
        if vlPost.upVotersUIDsArray.contains(currentUserUID) {
            print("💃")
            
            //remove userUID from array
            PostManager.shared.updateUpVotersArray(tiID: tiID, postID: vlPost.id, userUID: currentUserUID, addOrRemove: .remove) { error in
                
                if let error {print(error.localizedDescription); return }

                PostManager.shared.changeUpVotes(tiID: tiID, postID: vlPost.id, increaseOrDecrease: .decrease) { error in
                    
                    if let error {
                        print("💃" + error.localizedDescription + "💃")
                        return
                    }
                    
                    self.vlPost!.upVotersUIDsArray.remove(object: currentUserUID)
                    self.vlPost!.upVotes -= 1
                    self.vlPost!.totalVotes -= 1
                    
                    
                }
            }
            
        } else {
            //if Down Voted -----
            if vlPost.downVotersUIDsArray.contains(currentUserUID) {
                print("💅")
                PostManager.shared.updateDownVotersArray(tiID: tiID, postID: vlPost.id, userUID: currentUserUID, addOrRemove: .remove) { error in
                    
                    if error != nil { return }
                    
                    
                    PostManager.shared.changeDownVotes(tiID: tiID, postID: vlPost.id, increaseOrDecrease: .decrease) { error in
                        
                        if error != nil { return }
                        
                        self.vlPost!.downVotersUIDsArray.remove(object: currentUserUID)
                        self.vlPost!.downVotes -= 1
                        self.vlPost!.totalVotes += 1
                    }
                }
            }
            
            //Not Voted -----
            print("🦁")
            PostManager.shared.updateUpVotersArray(tiID: tiID, postID: vlPost.id, userUID: currentUserUID, addOrRemove: .add) { error in
                
                if let error {print(error.localizedDescription); return }

                PostManager.shared.changeUpVotes(tiID: tiID, postID: vlPost.id, increaseOrDecrease: .increase) { error in
                    
                    if let error {print(error.localizedDescription); return }
                    self.vlPost!.upVotersUIDsArray.append(currentUserUID)
                    self.vlPost!.upVotes += 1
                    self.vlPost!.totalVotes += 1
                }
            }
        }
        
        loadingUpVote = false
    }
    
    
    
    //MARK: - DOWNVOTE func
    private func downVote() {
        loadingDownVote = true

        guard let tiID   = ti?.id else { loadingDownVote = false; return }
        guard let vlPost = vlPost else { loadingDownVote = false; return }
        
        loadingDownVote = true
        
        //if already voted Down
        if vlPost.downVotersUIDsArray.contains(currentUserUID) {
            print("💃")
            
            PostManager.shared.updateDownVotersArray(tiID: tiID, postID: vlPost.id, userUID: currentUserUID, addOrRemove: .remove) { error in
                
                if let error {print(error.localizedDescription); return }

                PostManager.shared.changeDownVotes(tiID: tiID, postID: vlPost.id, increaseOrDecrease: .decrease) { error in
                    
                    if let error {print(error.localizedDescription); return }

                    
                    self.vlPost!.downVotersUIDsArray.remove(object: currentUserUID)
                    self.vlPost!.downVotes -= 1
                    self.vlPost!.totalVotes += 1
                    
                    
                }
            }
            
        } else {
            //if UP-Voted -----
            if vlPost.upVotersUIDsArray.contains(currentUserUID) {
                print("💅")
                PostManager.shared.updateUpVotersArray(tiID: tiID, postID: vlPost.id, userUID: currentUserUID, addOrRemove: .remove) { error in
                    
                    if error != nil { return }
                    
                    
                    PostManager.shared.changeUpVotes(tiID: tiID, postID: vlPost.id, increaseOrDecrease: .decrease) { error in
                        
                        if error != nil { return }
                        
                        self.vlPost!.upVotersUIDsArray.remove(object: currentUserUID)
                        self.vlPost!.upVotes -= 1
                        self.vlPost!.totalVotes -= 1
                    }
                }
            }
            
            //Not Voted -----
            print("🦁")
            PostManager.shared.updateDownVotersArray(tiID: tiID, postID: vlPost.id, userUID: currentUserUID, addOrRemove: .add) { error in
                

                if let error {print(error.localizedDescription); return }
                
                PostManager.shared.changeDownVotes(tiID: tiID, postID: vlPost.id, increaseOrDecrease: .increase) { error in
                    
                    
                    if let error {print(error.localizedDescription); return }

                    self.vlPost!.downVotersUIDsArray.append(currentUserUID)
                    self.vlPost!.downVotes += 1
                    self.vlPost!.totalVotes -= 1
                }
            }
        }
        
        loadingDownVote = false
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
