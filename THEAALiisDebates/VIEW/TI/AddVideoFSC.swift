//
//  AddVideoFSC.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/18/23.
//

import SwiftUI

//MARK: - ADD VIDEO FSC
struct AddVideoFSC: View {
    
    let tiID: String
    let tiChainLID: String
    
    let toWhat: String = "To Response List"
    @AppStorage("current_user_uid") var currentUserUID: String = ""

    @Binding var showFullScreenCover: Bool

    @ObservedObject private var addVideoVM = AddVideoViewModel()
    @State private var videoURL: String? = nil

    @State var videoThumbnailData: Data? = nil                  //URL
    @State private var videoTitle              = ""
    @State private var videoDescription        = ""
    
    enum Field {
        case videoTitle, videoDescription
    }
    @FocusState private var focusField: Field?
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 10) {
                
                StartATITTitleSV(leftText: "Add", rightText: "Video")
                Text(toWhat)
                    .font(.title2)
                
                
                PickThumbnailSV(thumbnailFor: .video,
                                thumbnailForTypeId: "change!",
                                imageData: $videoThumbnailData,
                                buttonText: "Pick Video Thumbnail")
                
                PickVideoButton(videoURL: $videoURL)
                    .padding(.vertical)
                
                //MARK: Video Title
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.13)
                    
                    if videoTitle == "" {
                        Text("Enter Video Title")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextField("", text: $videoTitle)
                        .multilineTextAlignment(.center)
                        .frame(width: width * 0.8, height: width * 0.1, alignment: .center)
                        .submitLabel(.done)
                        .focused($focusField, equals: .videoTitle)
                        .onSubmit { focusField = .videoDescription }
                    
                    
                }
                
                //MARK: Video Description
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.4)
                    
                    //FIXME: - BIO from database
                    if videoDescription == "" {
                        Text("Enter Video Description")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextEditor(text: $videoDescription)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                        .frame(width: width * 0.85, height: width * 0.35, alignment: .top)
                        .submitLabel(.return)
                        .focused($focusField, equals: .videoDescription)
                        .onSubmit { focusField = nil }
                }
                .frame(width: width * 0.8, height: width * 0.4, alignment: .top)
                
                
                
                //MARK: - Add video Button
                Button {

                    if addVideoButtonText == "Add Video to Response List" {
                        Task {
                            do {
                                let videoThumbnailURL = await ImageManager.shared.saveImage(imageData: videoThumbnailData, thumbnailFor: .video, thumbnailForTypeId: addVideoVM.videoId)
                                
                                try await addVideoVM.addVideo(tiId: tiID, chainLId: tiChainLID, videoURL: videoURL!, title: videoTitle, description: videoDescription, thumbnailURL: videoThumbnailURL, creatorId: currentUserUID)
                                
                                showFullScreenCover = false
                            }
                        }
                    }
                } label: {
                    
                    ZStack {

                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .frame(width: width * 0.9, height: width * 0.2)
                            .foregroundColor(addVideoButtonText == "Add Video to Response List" ? .ADColors.green : .secondary.opacity(0.5))


                        Text(addVideoButtonText)
                            .foregroundColor(addVideoButtonText == "Add Video to Response List" ? .ADColors.green : .primary)
                            .font(addVideoButtonText == "Add Video to Response List" ? .title : .body)


                    }
                    .padding(.top)
                    .foregroundColor(.primary)
                    .frame(width: width * 0.8, height: width * 0.2, alignment: .top)
                }
                
                
                Rectangle()
                    .fill(Color.black)
                    .frame(height: width)
                    .padding(.top)
            }
            .preferredColorScheme(.dark)
            .onTapGesture { focusField = nil }
        }
    }
    
    //MARK: - Functions
    var addVideoButtonText: String {

        if videoURL == nil {
            return("Provide The Video")
        } else if videoTitle == "" {
            return("Provide Video Title")
        } else if videoDescription == "" {
            return("Provide Video Description")
        } else {
            return "Add Video to Response List"
        }
    }
}

struct AddVideoFSC_Previews: PreviewProvider {
    static var previews: some View {
        AddVideoFSC(tiID: "id", tiChainLID: "cid", showFullScreenCover: .constant(true))
    }
}
