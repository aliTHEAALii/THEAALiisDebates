//
//  Video Manager.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/21/23.
//

import Foundation
import AVKit
import PhotosUI
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK: - Video Model
struct VideoModel: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "movie.mp4")
            
            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }
            
            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }
}

//MARK: - Video Manager
import FirebaseStorage

final class VideoManager {
    
    static let shared = VideoManager()
    private init() { }
    
    //STORAGE REF
    let storage = Storage.storage().reference()
    func videoStorageRef(videoID: String) -> StorageReference {
        storage.child("Videos").child(videoID)
    }
    func imageStorageRef(imageID: String) -> StorageReference {
        storage.child("Thumbnails").child(imageID)
    }
    
    //MARK: - 1. Create [ UP-Load ]
    func uploadVideo(video: VideoModel, videoID: String) async -> String? {
        
        let metadata = StorageMetadata()
        metadata.contentType = "video/mp4"
        
        do {
            //uploadTask
            let _ = try await videoStorageRef(videoID: videoID).putFileAsync(from: video.url, metadata: metadata)
//            let _ = try await videoStorageRef(videoID: videoID).putFile(
            
            print ("✅😎🎥  Video Saved! 🎥😎✅")
            
            //grab URL
            do {
                //                let videoURL = try await videoStorageRef.downloadURL()
                let videoURL = try await videoStorageRef(videoID: videoID).downloadURL()
                
                let videoURLString: String = videoURL.absoluteString
                return videoURLString
            } catch {
                print("🆘❌🤬🎥 ERROR: Could not get videoURL after saving video \(error.localizedDescription) 🎥🤬❌🆘")
                return nil
            }
        } catch {
            print ("❌🤬🎥 ERROR: uploading video to FirebaseStorage 🎥🤬❌")
            return nil
        }
    }
    func uploadVideoWithHandler(video: VideoModel, videoID: String, completion: @escaping (Result<String?, Error>) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "video/mp4"

        videoStorageRef(videoID: videoID).putFile(from: video.url, metadata: metadata) { _, putFileError in
                if let putFileError = putFileError {
                    print ("🆘🤬🎥 ERROR: uploading video to FirebaseStorage: \(putFileError.localizedDescription) 🎥🤬🆘")
                    completion(.failure(putFileError))
                    return
                }
                
            //Get Video URL
            self.videoStorageRef(videoID: videoID).downloadURL { url, downloadUrlError in
                    if let downloadUrlError = downloadUrlError {
                        print ("🆘🤬🎥 ERROR: getting download URL from FirebaseStorage: \(downloadUrlError.localizedDescription) 🎥🤬🆘")
                        completion(.failure(downloadUrlError))
                        return
                    }
                    
                    guard let url = url else {
                        print ("🆘🤬🎥 ERROR: URL is nil 🎥🤬🆘")
                        completion(.failure(NSError(domain: "URL is nil", code: -1, userInfo: nil)))
                        return
                    }
                    
                    print ("✅😎🎥  Video Saved! 🎥😎✅")
                    completion(.success(url.absoluteString))
                }
            }
        
    }
    
    
    //    // Pause the upload
    //    uploadTask.pause()
    //
    //    // Resume the upload
    //    uploadTask.resume()
    //
    //    // Cancel the upload
    //    uploadTask.cancel()
    
    //MARK: - 2. Read
    func getVideoURL(videoID: String) async throws -> String? {
        //grab URL
        do {
            let videoURL = try await videoStorageRef(videoID: videoID).downloadURL()
            let videoURLString: String = videoURL.absoluteString
            print("🧑🏻‍🏫👩🏻‍⚖️ Read Video URL String 🟠")
            print(videoURL)
            return videoURLString
            
        } catch {
            print("❌🤬🎥 ERROR: Could not get videoURL from video id \(error.localizedDescription) 🎥🤬❌")
            throw error
        }
    }
    
    //MARK: - 3. Update
    
    //MARK: - 4. Delete Video
    func deleteVideo(videoID: String) async throws {
        try await videoStorageRef(videoID: videoID).delete()
        print("👹 deleted Video 👺😈☠️")
    }
    
}
