//
//  TiView.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 5/29/24.
//

import SwiftUI

struct TiView: View {
    
    @AppStorage("current_user_id") var currentUserUID: String = ""
    
    @State var ti: TI? //FIXME: could be nil
    @State private var tiChain: [String] = []
    @State private var selectedChainLinkIndex: Int = 0
    @State private var tiChainLink: ChainLink? = nil
    @State var tiPost: Post?
    
    var ccVM = ControlCenterViewModel()
    
    @Binding var showTiView: Bool
    
    var body: some View {
        
        
        VStack(spacing: 0) {
            
            //            if let ti = ti {
            FSCHeaderSV(showFSC: $showTiView, text: ti?.title ?? "Couldn't get Ti")
            //            }
            
            //            Divider()
            // - Video
            if tiPost != nil {
                
                VideoSV(urlString: tiPost!.videoURL ?? "")
                
            } else {    //No Video Show text
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                        .frame(width: width, height: width * 0.5625)
                    //                    LoadingView(color: .gray)
                    //                        .frame(width: width, height: width * 0.5625)
                    
                    if let ti = ti {
                        Text(ti.description)
                            .frame(width: width, height: width * 0.5625)
                    }
                    
                }
            }
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0){
                    
                    //CC
                    ControlCenter(ti: $ti, tiChain: $tiChain, selectedChainLink: $selectedChainLinkIndex)

                    //Selected Post Info
                    TiPostInfo(ti: $ti, tiPost: $tiPost)
                    
                    //Vertical List
                    TiVerticalListView(ti: $ti, tiChain: $tiChain, tiChainLink: $tiChainLink, tiPost: $tiPost, selectedChainLinkIndex: $selectedChainLinkIndex)
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear{ onAppearFetch() }
        .onChange(of: selectedChainLinkIndex) { _, _ in fetchTiPost(); getChainLink() }
    }
    
    //MARK: - Functions
    private func onAppearFetch() {
        
        tiChain = ccVM.tiChain(ti: ti)
        selectedChainLinkIndex = ccVM.introPostIndex(ti: ti)
        getChainLink()
        fetchTiPost()
        
#if DEBUG
        TIManager.shared.getTi(tiID: TestingModels().tiFromDBID2) { result in
            switch result {
            case .success(let gottenTi):
                ti = gottenTi
                tiChain = ccVM.tiChain(ti: ti)
                selectedChainLinkIndex = ccVM.introPostIndex(ti: ti)
                getChainLink()
                fetchTiPost()
                
            case .failure(_):
                ti = nil
                tiPost = nil
            }
        }
#endif
        
        
    }

    func getChainLink() {
        guard let ti = ti else { return }
        let chainLinkID = tiChain[selectedChainLinkIndex]
        ChainLinkManager.shared.getChainLink(tiID: ti.id, chainID: chainLinkID) { result in
            switch result {
            
            case .success(let gottenChainLink):
                tiChainLink = gottenChainLink
            
            case .failure(_):
                tiChainLink = nil
            }
        }
    }
    
    private func fetchTiPost() {
        guard !tiChain.isEmpty else { return }
        guard let ti else { return }
        
        PostManager.shared.getPost(tiID: ti.id, postID: tiChain[selectedChainLinkIndex]) { result in
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
}



