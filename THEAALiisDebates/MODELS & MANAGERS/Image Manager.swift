//
//  Image Manager.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/15/23.
//

import SwiftUI
import FirebaseStorage

final class ImageManager {
    
    static let shared = ImageManager()
    private init() { }
    
    enum ThumbnailFor: String {
        case TI = "TIs_Thumbnails"
        case post = "Posts_Thumbnails"
        case video = "Video_Thumbnails"
        case user = "Profile_Images"
    }
    
//    let storage = Storage.storage()
//    let storageReference = storage.reference().child(thumbnailFor.rawValue).child(thumbnailForTypeId)
    let storage = Storage.storage().reference()
//    func videoStorageRef(videoID: String) -> StorageReference {
//        storage.child("Videos").child(videoID)
//    }
    private func imageStorageRef(imageId: String, thumbnailFor: ThumbnailFor) -> StorageReference {
//        storage.child("Thumbnails").child(imageID)
        storage.child(thumbnailFor.rawValue).child(imageId)
    }
    
    //MARK: -  Save Image FromData
    func saveImage(imageData: Data?, thumbnailFor: ThumbnailFor, thumbnailForTypeId: String) async -> String? {
        
        guard let imageData = imageData else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        
        let storage = Storage.storage()
        let storageReference = storage.reference().child(thumbnailFor.rawValue).child(thumbnailForTypeId)
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("😡📸 couldn't resize Image")
//            return false
            return nil
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg" // Setting metadata allows you to see console image in the web b: setting will work for png as well as jpeg
//        var imageURLString = "" // We'll set this after the image is successfully saved Variable 'imageURLString
        //MARK: Upload Data
        do {
            let _ = try await storageReference.putDataAsync(resizedImage, metadata: metadata)
            print ("🥬📸 Image Saved! 📸🥬")
            
            //MARK: get URL
            do {
                let imageURL = try await storageReference.downloadURL()
                return imageURL.absoluteString // We'll save this to Cloud Firestore as part of document in collection, below
            } catch {
                print("🤬 ERROR: Could not get imageURL after saving image \(error.localizedDescription)")
//                return false
                return nil
            }
        } catch {
            print ("🤬 ERROR: uploading image to FirebaseStorage")
//            return false
            return nil
        }
        
        
        //Save to the User document
//        let db = Firestore.firestore()
//        let userReference = db.collection("Users").document(currentUserUID)
        
//        do {
//            try await userReference.updateData(["profileImageURLString" : imageURLString])
//            return true
//
//        } catch {
//            print("🤬 ERROR: Could not update profileImageURL String in fireStore")
//            return false
//        }
    }
    
    
    //MARK: -  Read Image From URL
    func getImageFromURL(imageURL: URL?) async -> Data? {
        
        guard let imageURL = imageURL else { return nil }
        
            do {
                let imageData = try Data(contentsOf: imageURL as URL)
                return imageData
            } catch {
                print("❌📸🔻 Unable to load image data from URL: \(error)")
                return nil
            }
    }
    
    func getImage(urlString: String?) async -> Data? {
        
        guard let urlString = urlString else { return nil }
        guard let imageURL = URL(string: urlString) else { return nil }

        do {
            let imageData = try Data(contentsOf: imageURL as URL)
            return imageData
        }  catch {
            print("❌📸 Unable to load image data: \(error)")
            return nil
        }
    }
    
    
    //MARK: Delete
    func deleteImage(imageID: String, thumbnailFor: ThumbnailFor) async throws {
        try await imageStorageRef(imageId: imageID, thumbnailFor: thumbnailFor).delete()
    }
}
