//
//  PickVideoButton.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/12/23.
//

import AVKit
import PhotosUI
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift



@MainActor
final class PickVideoButtonVM: ObservableObject {
    
    func uploadVideoURL(videoModel: VideoModel, videoID: String) async -> String? {
        return await VideoManager.shared.uploadVideo(video: videoModel, videoID: videoID)
    }
}

//MARK: - View
struct PickVideoButton: View {
    
    @ObservedObject private var createTitVM = CreateTITVM()
    @StateObject private var videoVM = PickVideoButtonVM()

    @AppStorage("uploaded_video_id") var uploadedVideoID: String?

    ///
    @Binding var videoURL: String?
    
    enum LoadState {
        case unknown, loading, loaded, failed
    }
    
    
    @State private var selectedVideo: PhotosPickerItem?
    //    @State private var loadState = LoadState.unknown
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
                Text("Uploading: Please wait for it to finish. Don't close this view.")
                
            case .loaded:
//                 Text("😎🎥📄 VIDEO URL: \(createTitVM.videoURL ?? "") 👽🎥😎")
//                 Text("😎🎥📄🤖 VIDEO URL 2: \(videoURL ?? "") 🤖👽🎥😎")

                 //FIXME: Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
                 VideoPlayer(player: AVPlayer(url: URL(string: videoURL ?? "")! ) )
//                 if videoURL != nil {
//                     HVideoView(urlString: videoURL ?? "")
//                         .scaledToFit()
//                         .frame(width: width, height: width * 0.5625)
//                 }
                
                Text("Done Uploading")
                
            case .failed:
                Text("❌🎥Import Video failed🎥❌")
            }
            Button {
                showVideoPicker.toggle()
            } label: {
                PickVideoButtonSV()
            }
            .preferredColorScheme(.dark)
            .photosPicker(isPresented: $showVideoPicker, selection: $selectedVideo, matching: .videos)
            ///https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-import-videos-using-photospicker
            //MARK: - Logic
            .onChange(of: selectedVideo) { _ in
                Task {
                    do {
                        loadState = .loading
                        
//                        createTitVM.videoURL = nil
                        
                        if let movie = try await selectedVideo?.loadTransferable(type: VideoModel.self) {
                            
                            let downloadedvideoURL: String? = await videoVM.uploadVideoURL(videoModel: movie, videoID: createTitVM.videoId)
                            
                            uploadedVideoID = createTitVM.videoId
                            
                            createTitVM.videoURL = downloadedvideoURL
                            ///
                            videoURL = downloadedvideoURL
                            loadState = .loaded
                            print("😎🎥👽 VIDEO URL: \(movie.url) 👽🎥😎")
                        } else {
                            loadState = .failed
                        }
                    } catch {
                        loadState = .failed
                    }
                }
            }
        }
    }
}

struct PickVideoButton_Previews: PreviewProvider {
    static var previews: some View {
        //        PickVideoButton(videoURL: <#Binding<String?>#>)
        CreateDebateFSC(selectedTabIndex: .constant(1), showFullScreenCover: .constant(true))
    }
}

//MARK: Pick Video Button SV
struct PickVideoButtonSV: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(lineWidth: 1)
                .foregroundColor(.gray)
                .frame(width: width * 0.4, height: width * 0.15)
            
            //                Text("Pick \(Image(systemName: "triangle")) video")
            //                    .foregroundColor(.ADColors.green)
            HStack(spacing: 0) {
                
                Text("Pick")
                    .font(.system(size: width * 0.05, weight: .light))
                    .foregroundColor(.ADColors.green)
                    .frame(width: width * 0.3, alignment: .trailing)
                
                Image(systemName: "triangle")
                    .font(.system(size: width * 0.05, weight: .light))
                    .foregroundColor(.ADColors.green)
                    .frame(width: width * 0.1)
                    .rotationEffect(Angle(degrees: 90))
                
                
                Text("Video")
                    .font(.system(size: width * 0.05, weight: .light))
                    .foregroundColor(.ADColors.green)
                    .frame(width: width * 0.3, alignment: .leading)
                
            }
        }
        .frame(width: width * 0.8)
    }
}



//MARK: - View
struct PickAVideoButton: View {
    
    @ObservedObject private var createTitVM = CreateTITVM()
    @StateObject private var videoVM = PickVideoButtonVM()

    @AppStorage("uploaded_video_id") var uploadedVideoID: String?

    ///
    @Binding var videoURL: String?
    
    enum LoadState {
        case unknown, loading, loaded, failed
    }
    
    
    @State private var selectedVideo: PhotosPickerItem?
    //    @State private var loadState = LoadState.unknown
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
                Text("Uploading: Please wait for it to finish. Don't close this view.")
                
            case .loaded:
//                 Text("😎🎥📄 VIDEO URL: \(createTitVM.videoURL ?? "") 👽🎥😎")
//                 Text("😎🎥📄🤖 VIDEO URL 2: \(videoURL ?? "") 🤖👽🎥😎")

                 //FIXME: Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
                 VideoPlayer(player: AVPlayer(url: URL(string: videoURL ?? "")! ) )
//                 if videoURL != nil {
//                     HVideoView(urlString: videoURL ?? "")
//                         .scaledToFit()
//                         .frame(width: width, height: width * 0.5625)
//                 }
                
                Text("Done Uploading")
                
            case .failed:
                Text("❌🎥Import Video failed🎥❌")
            }
            Button {
                showVideoPicker.toggle()
            } label: {
                PickVideoButtonSV()
            }
            .preferredColorScheme(.dark)
            .photosPicker(isPresented: $showVideoPicker, selection: $selectedVideo, matching: .videos)
            ///https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-import-videos-using-photospicker
            //MARK: - Logic
            .onChange(of: selectedVideo) { _ in
                Task {
                    do {
                        loadState = .loading
                        
//                        createTitVM.videoURL = nil
                        
                        if let movie = try await selectedVideo?.loadTransferable(type: VideoModel.self) {
                            
                            let downloadedvideoURL: String? = await videoVM.uploadVideoURL(videoModel: movie, videoID: createTitVM.videoId)
                            
                            uploadedVideoID = createTitVM.videoId
                            
                            createTitVM.videoURL = downloadedvideoURL
                            ///
                            videoURL = downloadedvideoURL
                            loadState = .loaded
                            print("😎🎥👽 VIDEO URL: \(movie.url) 👽🎥😎")
                        } else {
                            loadState = .failed
                        }
                    } catch {
                        loadState = .failed
                    }
                }
            }
        }
    }
}
