//
//  PickIntroVideoButton.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 7/15/24.
//

import SwiftUI

//MARK: - Pick Intro Video Button
import AVKit
import PhotosUI
//import FirebaseFirestore
//import FirebaseFirestoreSwift

struct PickIntroVideoButton: View {
    
    //    @ObservedObject private var createTitVM = CreateTITVM()
    //    @StateObject    private var videoVM     = PickVideoButtonVM()
    
    @AppStorage("uploaded_video_id") var uploadedVideoID: String? //FIXME: should remove this
    let tiID: String
    var videoID: String = ""
    ///
    @State var videoURL: String? = nil //For pick video button
    @Binding var introPost: Post?
    
    enum LoadState {
        case unknown, loading, loaded, failed
    }
    
    @State private var selectedVideo: PhotosPickerItem?
    @State private var loadState: LoadState = .unknown
    
    @Environment(\.dismiss) private var dismiss
    @State private var showVideoPicker = false
    
    var body: some View {
        
        VStack {
            
            switch loadState {
                
            case .unknown:
                EmptyView()
                
            case .loading:
                ProgressView()
                Text("Uploading: Please wait for it to finish.\nDon't close this view.")
                    .foregroundStyle(.red)
                
            case .loaded:
                
                if videoURL != nil {
                    VideoPlayer(player: AVPlayer(url: URL(string: videoURL ?? "")! ) )
                }
                Text("Done Uploading")
                
            case .failed:
                Text("❌🎥Uploading Video FAILED🎥❌")
            }
            
            //MARK: - Pick Video Button
            Button {
                showVideoPicker.toggle()
                
            } label: {
                if videoURL != nil || loadState == .loading {
                    HStack {
                        AddButtonSV()
                        
                        Text("Pick Another Intro Video")
                            .foregroundStyle(Color.ADColors.green)
                    }
                    .frame(height: width * 0.15)
                    .foregroundStyle(.secondary)
                } else {
                    HStack {
                        AddButtonSV()
                        
                        Text("Add Intro Video")
                            .foregroundStyle(Color.ADColors.green)
                    }
                    .frame(height: width * 0.15)
                }
            }
            .foregroundStyle(.primary)
            .preferredColorScheme(.dark)
            //MARK: - Logic
            .photosPicker(isPresented: $showVideoPicker, selection: $selectedVideo, matching: .videos)
            ///https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-import-videos-using-photospicker
            .onChange(of: selectedVideo) { _, _ in
                loadState = .loading
                
                Task {
                    await upLoadVideo()
                }
            }
        }
    }
    
    
    func upLoadVideo() async {
        
        guard introPost != nil else { return }
        Task {
            do {
                
                let pickedVideo =  try await selectedVideo?.loadTransferable(type: VideoModel.self)
                
                if pickedVideo != nil {
                    let videoURLString = await VideoManager.shared.uploadVideo(video: pickedVideo!, videoID: tiID)
                    
                    
                    if videoURLString != nil {
                        try await PostManager.shared.updateIntroPostVideo(tiID: tiID, videoUrlString: videoURLString!)
                        
                        introPost!.videoURL = videoURLString
                        introPost!.type = .video
                        videoURL = videoURLString
                        
                        loadState = .loaded
                    }
                }
                
            } catch {
                print("🆘😎🎥👽 VIDEO URL: \(error.localizedDescription) 👽🎥😎❌")
            }
        }
    }
    
    func uploadVideoURL(videoModel: VideoModel, videoID: String) async -> String? {
        return await VideoManager.shared.uploadVideo(video: videoModel, videoID: videoID)
    }
}

#Preview {
    TiView(ti: nil, showTiView: .constant(true))

//    PickIntroVideoButton()
}
