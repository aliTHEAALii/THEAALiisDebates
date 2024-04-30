//
//  AddTITVideoToListButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/18/23.
//

import SwiftUI

//MARK: - ADD TIT VIDEO BUTTON
struct AddTIVideoButton: View {
    
    let tiID: String
    let tiChainLID: String
    
    @State private var showAddVideoFSC: Bool = false
    
    var body: some View {
        
        Button {
            showAddVideoFSC.toggle()
        } label: {
            AddButtonSV()
        }
        .preferredColorScheme(.dark)
        .fullScreenCover(isPresented: $showAddVideoFSC) {
            
            ZStack(alignment: .topTrailing) {
//
//                //Create TIT View
//                CreateDebateFSC(selectedTabIndex: $selectedTabIndex, showFullScreenCover: $showCreateTITFSC)
                AddVideoFSC(tiID: tiID, tiChainLID: tiChainLID, showFullScreenCover: $showAddVideoFSC)
//
//                //MARK: - Close Button
                Button {
//                    Task {
//                        if uploadedVideoID != nil {
////                            print("🧀🧀🧀🦠 uploaded_video_id: \(uploadedVideoID)")
//                            try await createTitVM.deleteVideo(videoID: uploadedVideoID!)
//                        }`
                        showAddVideoFSC = false
//                        selectedTabIndex = 0
//                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: width * 0.1, height: width * 0.1)
                            .foregroundColor(.black)

                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(lineWidth: 0.7)
                            .frame(width: width * 0.1, height: width * 0.1)
                            .foregroundColor(.white)

                        Image(systemName: "xmark")
                            .font(.system(size: width * 0.075, weight: .thin))
                            .foregroundColor(.primary)
                    }
                    .padding(.trailing)

                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

//MARK: - Preview
struct AddTIVideoButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTIVideoButton(tiID: "id", tiChainLID: "cid")
    }
}


//MARK: - Add Video View Model
@MainActor
final class AddVideoViewModel: ObservableObject {
    let videoId: String = UUID().uuidString

    func addVideo(tiId: String, chainLId: String, videoURL: String, title: String, description: String, thumbnailURL: String?, creatorId: String) async throws {
        
        let titVideo = TIVideoModel(id: videoId, videoURL: videoURL, thumbnail: thumbnailURL, creatorID: creatorId, name: title, description: description, chainLId: chainLId)
        
        Task {
            do {
                try await TITVideoManager.shared.createTitVideo(titID: tiId, titVideo: titVideo)
                
//                try await TITChainLManager.shared.addtoCLResponseList(titId: tiId, titChainLId: chainLId, titVideoId: videoId)
                try await TITChainLManager.shared.addToResponseList(tiId: tiId, tiChainId: chainLId, tiVideoId: videoId)
            } catch {
                print("❌🔺Error: Couldn't add TIVideo")
            }
        }
    }
}
