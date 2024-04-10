//
//  PickThumbnailSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/15/23.
//

import SwiftUI
import PhotosUI
//import UIKit
//import FirebaseStorage
import Firebase

struct PickThumbnailSV: View {
    
    enum ThumbnailFor: String {
        case TIT = "TIT_Thumbnails", video = "Video_Thumbnails"
    }
    
    let thumbnailFor: ThumbnailFor
    let thumbnailForTypeId: String
    //    @Binding var imageURL: String?
    @Binding var imageData: Data? //URL
    
    let buttonText: String
    
    @AppStorage("user_UID") var currentUserUID: String = ""
    
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker = false
    @State var selectedPhoto: PhotosPickerItem?
    
    //MARK: View
    var body: some View {
        
        HStack() {
            
            Text(buttonText)
                .foregroundColor(.secondary)
                .padding(.leading)
            
            Spacer()
            
            //remove Image Button
            if imageData != nil {
                Button {
                    imageData = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            
            //pickImageButton
            Button {
                showImagePicker.toggle() //= TestingComponents().imageURLStringDesignnCode
            } label: {
                if imageData == nil {
                    ZStack {
                        Image(systemName: "photo")
                            .foregroundColor(.secondary)
                            .font(.system(size: width * 0.15, weight: .thin))
                        
                    }
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: width * 0.3, height: width * 0.5625 * 0.3)
                        
                        Image(uiImage: UIImage(data: imageData! )!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: width * 0.3, height: width * 0.5625 * 0.3)
                    }
                }
            }
            .padding(.trailing)
            .foregroundColor(.primary)
            
        }
        .frame(width: width, alignment: .leading)
        .preferredColorScheme(.dark)
        //MARK: pick
        .photosPicker(isPresented: $showImagePicker, selection: $selectedPhoto)
        .onChange(of: selectedPhoto) { newValue in
            //extracting uiImage from photoItem
            if let newValue {
                Task {
                    do {
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                        
                        await MainActor.run(body: {
                            self.imageData = imageData
                        })
                        
                        //                        let _ = await saveImage(image: UIImage(data: imageData)!)
                        
                    } catch {
                        print("❌🤬📸Error: selecting image failed\(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    //MARK: - Save Image
    
    //MARK: - Function [ Save Image ]
//    func saveImage(image: UIImage) async -> Bool {
//
//        let storage = Storage.storage()
//        let storageReference = storage.reference().child(thumbnailFor.rawValue).child(thumbnailForTypeId)
//
//        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
//            print("😡📸 couldn't resize Image")
//            return false
//        }
//
//        let metadata = StorageMetadata ()
//        metadata.contentType = "image/jpg" // Setting metadata allows you to see console image in the web b: setting will work for png as well as jpeg
//        var imageURLString = "" // We'll set this after the image is successfully saved Variable 'imageURLString
//        do {
//            let _ = try await storageReference.putDataAsync(resizedImage, metadata:metadata)
//            print ("📸 a Image Saved!")
//
//            do {
//                let imageURL = try await storageReference.downloadURL()
//                imageURLString = "\(imageURL)" // We'll save this to Cloud Firestore as part of document in collection, below
//            } catch {
//                print("🤬 ERROR: Could not get imageURL after saving image \(error.localizedDescription)")
//                return false
//            }
//        } catch {
//            print ("🤬 ERROR: uploading image to FirebaseStorage")
//            return false
//        }
//
//
//        //Save to the User document
//        let db = Firestore.firestore()
//        let userReference = db.collection("Users").document(currentUserUID)
//
//        do {
//            try await userReference.updateData(["profileImageURLString" : imageURLString])
//            return true
//
//        } catch {
//            print("🤬 ERROR: Could not update profileImageURL String in fireStore")
//            return false
//        }
//
//    }
}

struct PickThumbnailSV_Previews: PreviewProvider {
    static var previews: some View {
        
        CreateTIFSC(showFSC: .constant(true), selectedTabIndex: .constant(2))
        CreateDebateFSC(selectedTabIndex: .constant(2), showFullScreenCover: .constant(true))
        
        //        PickThumbnailSV(imageURL: .constant(TestingComponents().imageURLStringDesignnCode), buttonText: "TIT Thumbnail")
        //        PickThumbnailSV(imageURL: .constant(nil), buttonText: "TIT Thumbnail")
    }
}


//MARK: - Pick Thumbnail Button
struct PickThumbnailButton: View {
    
    //FIXME: TII - TI
    enum ThumbnailFor: String {
        case TI = "TI_Thumbnails", video = "Video_Thumbnails"
    }
    
    let thumbnailFor: ThumbnailFor
    let thumbnailForTypeID: String
    
    @Binding var imageData: Data? //URL
    
    let buttonText: String
    
    @AppStorage("current_user_id") var currentUserUID: String = ""
    
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker = false
    @State var selectedPhoto: PhotosPickerItem?
    
    //MARK: View
    var body: some View {

        Button {
            showImagePicker.toggle()
        } label: {
            ZStack {
                
                if imageData == nil {
                    Text("THEAALii's Interaction \nThumbnail")
                        .font(.title2)
                        .foregroundColor(.primary)
                } else {
                    Image(uiImage: UIImage(data: imageData! )!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
//                        .frame(width: width * 0.4, height: width * 0.5625 * 0.4)
                        .frame(width: width, height: width * 0.5625)

                }
                
                //Border
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(imageData != nil ? .primary : .red)
//                    .frame(width: width * 0.4, height: width * 0.5625 * 0.4)
                    .frame(width: width, height: width * 0.5625)

            }
        }
//        .frame(width: width, alignment: .leading)
        .preferredColorScheme(.dark)
        //MARK: pick
        .photosPicker(isPresented: $showImagePicker, selection: $selectedPhoto)
        .onChange(of: selectedPhoto) { newValue in
            //extracting uiImage from photoItem
            if let newValue {
                Task {
                    do {
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else { return }
                        
                        await MainActor.run(body: {
                            self.imageData = imageData
                        })
                        
                        //                        let _ = await saveImage(image: UIImage(data: imageData)!)
                        
                    } catch {
                        print("❌🤬📸Error: selecting image failed\(error.localizedDescription)")
                    }
                }
            }
        }
    }
        
    //MARK: - Function [ Save Image ]
}
