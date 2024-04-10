//
//  DebateCard.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/8/23.
//

import SwiftUI

struct TITCard: View {
    
    @Binding var showTITView: Bool
    //MARK: FIX THIS Observable Object
    @ObservedObject var vmTIT: TITViewModel = TITViewModel()
    @AppStorage("tit_id") var TITid: String = ""

    
    let debateID: String
    let debateName: String
    
    var TIT: TIModel?
//    @Binding var TIT: TITModel?
    //let debateCreator: String
    //let debateThumbnailURL: String
    
    var body: some View {
        
        Button {
//            vmTIT.TIT = TIT
            Task {
                guard let TIT = TIT else { return }
                TITid = TIT.id
//                vmTIT.TIT = TIT
//                print("🦠🧬🧿 TITCard 0 ⬇️🔗🧬🦠" + TIT.id)
//                print("🦠🧬🧿 TITCard 1 ⬇️🔗🧬🦠" + (vmTIT.TIT?.id ?? "nil"))

                try await vmTIT.getTIT(titId: TIT.id)
                print("🔻 vmTIT.getTIT(titID: 🔻" + (vmTIT.TIT?.id ?? "nil"))

                showTITView.toggle()
            }
            
        } label: {
            
            VStack(spacing: 0) {
                
                //TODO: Video
                ZStack(alignment: .bottom) {
                    
                    //FIXME: Debate Chains Count
                    DebateCardIndicatorCirclesSV(debateChainsCount: TIT?.interactionChain.count ?? 0)
                    
                    //Border
                    RoundedRectangle(cornerRadius: 8)
                        .trim(from: 0, to: 0.5)
                        .stroke(lineWidth: 1)
                        .frame(width: width * 0.45, height: width * 0.15)
                        .foregroundColor(.primary)
                    
                    
                    // 0.5625 + 0.0575 = 0.61
                    VStack(spacing: 0) {
                        
                        ///if there is a thumbnail show it. else show video
                        //Thumbnail
                        AsyncImage(
                            url: URL(string: TIT?.thumbnailURLString ?? ""),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: width, maxHeight: width * 0.5625)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        .frame(width: width, height: width * 0.5625)
                        Rectangle()
                            .frame(width: width, height: width * 0.08)
                            .foregroundColor(.clear)
                    }
                }
                
                //FIXME: Debate Title
                HStack(spacing: 0) {
                    Text(TIT?.name ?? "no TIT")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 5)
                        .frame(width: width * 0.85, height: width * 0.15, alignment: .topLeading)
                    
                    UserButton(userID: TIT?.creatorUID, imageURL: TIT?.thumbnailURLString) //FIXME
                    
                }
                .frame(height: width * 0.18)
                
//                Divider()
                Rectangle()
                    .fill(.secondary)
                    .opacity(0.1)
                    .frame(height: width * 0.02)
            }
            .foregroundColor(.primary)
        }
    }
}

struct TITCard_Previews: PreviewProvider {
    static var previews: some View {

//        TabsBarCustomized()
        //        FeedTabView(showDebateView: .constant(false))

        TITCard(showTITView: .constant(false), debateID: "debateID", debateName: "test Name", TIT: TestingComponents().testingTIT)
            .preferredColorScheme(.dark)
    }
}
