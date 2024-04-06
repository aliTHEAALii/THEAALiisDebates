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
    //    let videoStorageRef = Storage.storage().reference().child("Videos").child(UUID().uuidString)
    
    //MARK: - 1. Create [ UP-Load ]
    func uploadVideo(video: VideoModel, videoID: String) async -> String? {
        
        let metadata = StorageMetadata ()
        metadata.contentType = "video/mp4"
        do {
            //uploadTask
            let _ = try await videoStorageRef(videoID: videoID).putFileAsync(from: video.url, metadata: metadata)
            
            print ("😎🎥  Video Saved! 🎥😎")
            
            //grab URL
            do {
                //                let videoURL = try await videoStorageRef.downloadURL()
                let videoURL = try await videoStorageRef(videoID: videoID).downloadURL()
                
                let videoURLString: String = videoURL.absoluteString
                return videoURLString
            } catch {
                print("❌🤬🎥 ERROR: Could not get videoURL after saving video \(error.localizedDescription) 🎥🤬❌")
                return nil
            }
        } catch {
            print ("❌🤬🎥 ERROR: uploading video to FirebaseStorage 🎥🤬❌")
            return nil
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
