//
//  CreateTIViewMedia.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/23/24.
//

import Foundation

//MARK: - Logic

//ti Title                          //
//ti thumbbnail                     //
//intro paragraph                   //
//ti Admins UIDs                    //

///if d1
//ti d1                             //
//

///else if d2
// ti d2
// left  User
// Right User




///ti  creator
//add to created TIs
//add Observing TIs



@MainActor
final class CreateTIVM: ObservableObject {
    
//    @Published var videoID: String = UUID().uuidString
    let TIID: String = UUID().uuidString
    let videoId: String = UUID().uuidString

    @Published var videoURL: String?

    
    func createTIT(
        tiTitle: String,
        tiDescription: String,
        tiThumbnailURL: String?,
        
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
                id: TIID,
                name: tiTitle,
                description: tiDescription,
            thumbnailURLString: tiThumbnailURL,
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
