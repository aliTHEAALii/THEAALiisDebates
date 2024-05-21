//
//  CreateDebateButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/21/23.
//

import SwiftUI

//MARK: - View
struct CreateDebateButton: View {
    
    @StateObject var createTitVM = CreateTITVM()
    
    @AppStorage("uploaded_video_id") var uploadedVideoID: String?
    
    
    @Binding var selectedTabIndex: Int
    @State var showCreateTITFSC = false
    
    var body: some View {
        
        Button {
            showCreateTITFSC.toggle()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: width * 0.08, weight: .thin))
                .frame(width: width * 0.1)
                .foregroundColor(.secondary)
            
        }
        //MARK: - FSC
        .fullScreenCover(isPresented: $showCreateTITFSC) {
//            ZStack(alignment: .topTrailing) {
//                
//                //Create TIT View
//                CreateDebateFSC(selectedTabIndex: $selectedTabIndex, showFullScreenCover: $showCreateTITFSC)
//                
//                
//                //MARK: - Close Button
//                Button {
//                    Task {
//                        if uploadedVideoID != nil {
////                            print("🧀🧀🧀🦠 uploaded_video_id: \(uploadedVideoID)")
//                            try await createTitVM.deleteVideo(videoID: uploadedVideoID!)
//                        }
//                        showCreateTITFSC = false
//                        selectedTabIndex = 0
//                    }
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .frame(width: width * 0.1, height: width * 0.1)
//                            .foregroundColor(.black)
//                        
//                        RoundedRectangle(cornerRadius: 10)
//                            .strokeBorder(lineWidth: 0.7)
//                            .frame(width: width * 0.1, height: width * 0.1)
//                            .foregroundColor(.white)
//                        
//                        Image(systemName: "xmark")
//                            .font(.system(size: width * 0.075, weight: .thin))
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.trailing)
//                    
//                }
//            }
            
            CreateTI(showFSC: $showCreateTITFSC, selectedTabIndex: $selectedTabIndex)
        }
    }
}

struct CreateDebateButton_Previews: PreviewProvider {
    static var previews: some View {
        TabsBar()
//        CreateDebateButton(selectedTabIndex: .constant(2), showCreateTITFSC: false)
//            .preferredColorScheme(.dark)
    }
}


//MARK: CreateTIT View Model
//@MainActor
final class CreateTITVM: ObservableObject {
    
//    @Published var videoID: String = UUID().uuidString
    let TITId: String = UUID().uuidString
    let videoId: String = UUID().uuidString

    @Published var videoURL: String?

    
    func createTIT(
        titName: String,
        titDescription: String,
        titThumbnailURL: String?,
        
        firstTitVideoName: String,
        firstTitVideoDescription: String,
        firstVideoThumbnailURL: String?,
        creatorID: String,
//                   firstvideoID: String,
        firstVideoURL: String
    ) async throws {
            
            //create instances
            //TODO: - Thumbnail & tit name
            let tit = TIModel(
                id: TITId,
                name: titName,
                description: titDescription,
                thumbnailURLString: titThumbnailURL,
                creatorUID: creatorID,
                administratorsUID: []
            )
            
            //TODO: - Thumbnail & tit name & VideoId
            let titVideo = TIVideoModel(
                id: videoId,
                videoURL: firstVideoURL,
                thumbnail: firstVideoThumbnailURL,
                creatorID: creatorID,
                name: firstTitVideoName,
                description: firstTitVideoDescription,
                chainLId: nil
            )
            
            let titChainLink = TITChainLinkModel(id: UUID().uuidString, postID: titVideo.id, verticalList: [])
            
            Task {
            do {
                try await TITManager.shared.createTIT(TITModel: tit)
                try await TITVideoManager.shared.createTitVideo(titID: tit.id, titVideo: titVideo)
                try await TITChainLinkManager.shared.createTITChainLink(TITid: tit.id, TITChainLink: titChainLink)
                
                try await TITManager.shared.addToChain(titId: tit.id, chainId: titChainLink.id)
                
            } catch {
                print("❌❌❌ Error: Couldn't Create TI ❌❌❌")
            }
        }
    }
    
    //MARK: Delete Video
    func deleteVideo(videoID: String) async throws {
        Task {
            do {
                try await VideoManager.shared.deleteVideo(videoID: videoID)
                print("😈😏 video Deleted 🫥🫥👹")
            } catch {
                print("❌🎥 couldn't delete video 🎥❌ \(error.localizedDescription)")
                throw error
            }
        }
    }
}
