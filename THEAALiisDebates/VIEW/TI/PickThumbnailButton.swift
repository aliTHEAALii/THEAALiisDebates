//
//  PickThumbnailButton.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 6/5/24.
//

import SwiftUI
import PhotosUI
//import UIKit
//import FirebaseStorage
import Firebase

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
//        .onChange(of: selectedPhoto) { newValue in
        .onChange(of: selectedPhoto) { oldValue, newValue in

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


#Preview {
    PickPostThumbnailButton(thumbnailFor: .video, thumbnailForTypeID: "meaw.id", imageData: .constant(nil), buttonText: "trying this")
}


struct PickPostThumbnailButton: View {
    
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
                    Text("Post \nThumbnail")
                        .font(.caption)
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
//                    .frame(width: width * 0.25, height: width * 0.5625 * 0.25)
                    .frame(width: width * 0.22, height: width * 0.5625 * 0.22)



            }
        }
//        .frame(width: width, alignment: .leading)
        .preferredColorScheme(.dark)
        //MARK: pick
        .photosPicker(isPresented: $showImagePicker, selection: $selectedPhoto)
//        .onChange(of: selectedPhoto) { newValue in
        .onChange(of: selectedPhoto) { oldValue, newValue in

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
