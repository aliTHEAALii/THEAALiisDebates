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
            // - uploadTask
            let _ = try await videoStorageRef(videoID: videoID).putFileAsync(from: video.url, metadata: metadata)
            
            print ("✅😎🎥  Video Saved! 🎥😎✅")
            
            
            // - grab URL
            do {
                let videoURL = try await videoStorageRef(videoID: videoID).downloadURL()
                
                let videoURLString: String = videoURL.absoluteString
                return videoURLString
            } catch {
                print("🆘❌🤬🎥 ERROR: Could not get videoURL after saving video \(error.localizedDescription) 🎥🤬❌🆘")
                throw error
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
            let videoUrlString = try await videoStorageRef(videoID: videoID).downloadURL().absoluteString
            print("🟢🧑🏻‍🏫👩🏻‍⚖️ Got Video URL String \(videoUrlString) 🟢")
            return videoUrlString
            
        } catch {
            print("❌🤬🎥 ERROR: Could not get videoURL String from video id \(error.localizedDescription) 🎥🤬❌")
            throw error
        }
    }
    
    //MARK: - 3. Update
    
    //MARK: - 4. Delete Video
    func deleteVideo(videoID: String) async throws {
        try await videoStorageRef(videoID: videoID).delete()
        print("👹☠️ DELETED VIDEO ☠️👹")
    }
    
}




//MARK: - Video Progress (Future Feature)
//import FirebaseStorage
//
//func uploadVideo(videoID: String, uploadData: Data) {
//    let metadata = StorageMetadata()
//    metadata.contentType = "video/mp4" // or any other appropriate MIME type
//
//    let storageRef = videoStorageRef(videoID: videoID)
//    
//    storageRef.putData(uploadData, metadata: metadata) { metadata, error in
//        if let error = error {
//            print("Error uploading video: \(error.localizedDescription)")
//            return
//        }
//        
//        guard let metadata = metadata else {
//            print("No metadata returned")
//            return
//        }
//        
//        print("Upload complete. Metadata: \(metadata)")
//    }.observe(.progress) { snapshot in
//        guard let progress = snapshot.progress else { return }
//        let percentComplete = 100.0 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
//        print("Upload is \(percentComplete)% complete")
//        
//        // Update your UI with the progress value
//        DispatchQueue.main.async {
//            // Example: Update a progress bar
//            self.uploadProgress = percentComplete
//        }
//    }
//}
//
//private func videoStorageRef(videoID: String) -> StorageReference {
//    return Storage.storage().reference().child("videos/\(videoID).mp4")
//}
//
//// Example of a progress property in a SwiftUI view
//@State private var uploadProgress: Double = 0.0
//
