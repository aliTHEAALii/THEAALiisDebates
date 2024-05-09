//
//  UploadToTIChain.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/18/23.
//

import SwiftUI

struct UploadToTIChainFSC: View {
    
    let ti: TIModel
    @Binding var showFSC: Bool
    
    @AppStorage("current_user_id") var currentUserID: String = ""
    
    @ObservedObject private var vmControls = TIContolsViewModel()
    
    let tiVideoId: String = UUID().uuidString
    @State var tiVideoThumbnailData: Data? = nil
    @State var videoURL: String? = nil
    @State var videoTitle: String = ""
    @State var videoDescription = ""
    
    enum Field {
        case videoTitle
    }
    @FocusState private var focusField: Field?
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // - FSC Title
            Text("UP-load Video to T.I. Chain")
                .font(.title)
                .foregroundColor(.ADColors.green)
                .padding(.all)
                .frame(width: width, height: width * 0.1, alignment: .leading)
            
            ScrollView {
                
                // - Thumbnail
                PickThumbnailSV(thumbnailFor: .video, thumbnailForTypeId: tiVideoId,
                                imageData: $tiVideoThumbnailData,
                                buttonText: "Pick Video Thumbnail")
                .padding(.vertical, width * 0.1)
                
                PickVideoButton(videoURL: $videoURL)
                
                
                // - Video Title
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.13)
                    
                    if videoTitle == "" {
                        Text("Enter First Video Title")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextField("", text: $videoTitle)
                        .multilineTextAlignment(.center)
                        .frame(width: width * 0.8, height: width * 0.2, alignment: .center)
                        .submitLabel(.done)
                        .focused($focusField, equals: .videoTitle)
                        .onSubmit { focusField = nil }
                }
                .padding(.vertical, width * 0.1)
                // Video Title - //
                
                // - Video Description
                EnterDescriptionButton(description: $videoDescription)
                
                //MARK:  Upload Button
                Button {
                    Task {
                        try await upLoadTIVideoToChain()
                        showFSC = false
                    }
                } label: {
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .frame(width: width * 0.9, height: width * 0.2)
                            .foregroundColor(createVideoButtonText == "Upload Video To TI Chian" ? .ADColors.green : .secondary.opacity(0.5))
                        
                        
                        Text(createVideoButtonText)
                            .foregroundColor(createVideoButtonText == "Upload Video To TI Chian" ? .ADColors.green : .primary)
                            .font(createVideoButtonText == "Upload Video To TI Chian" ? .title : .body)
                        
                    }
                    .padding(.top)
                    .foregroundColor(.primary)
                    .frame(width: width * 0.8, height: width * 0.2, alignment: .top)
                }
            }
        }
        .onTapGesture { focusField = nil }
        .preferredColorScheme(.dark)
    }
    
    //MARK: - Functions
    var createVideoButtonText: String {
        if videoURL == nil {
            return("Provide The Video")
        } else if videoTitle == "" {
            return("Provide Video Title")
        } else if videoDescription == "" {
            return("Provide Video Description")
        } else {
            return "Upload Video To TI Chian"
        }
    }
    
    //MARK: upLoadTIVideoToChain
    func upLoadTIVideoToChain() async throws {
        
        guard createVideoButtonText == "Upload Video To TI Chian" else { return }
        guard let videoURL = videoURL else { return }
        
        Task {
            let vURL = await ImageManager.shared.saveImage(imageData: tiVideoThumbnailData, thumbnailFor: .video, thumbnailForTypeId: tiVideoId)
            
            let tiVideo = TIVideoModel(id: tiVideoId, videoURL: videoURL, thumbnail: vURL, creatorID: currentUserID, name: videoTitle, description: videoDescription, chainLId: nil)
            try await vmControls.uploadTIVideoToTIChain(ti: ti, tiVideo: tiVideo)
        }
    }
}

struct UploadToTIChainFSC_Previews: PreviewProvider {
    static var previews: some View {
        UploadToTIChainButton(ti: TestingModels().testingTI)
            .preferredColorScheme(.dark)
        
        UploadToTIChainFSC(ti: TestingModels().testingTI, showFSC: .constant(true))
    }
}

//MARK: - Upload To TI Chain Button
struct UploadToTIChainButton: View {
    
    let ti: TIModel

    @State private var showFSC: Bool = false
    
    var body: some View {
        
        Button {
            showFSC.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.12, height: width * 0.12)
                Image(systemName: "plus")
                    .font(.system(size: width * 0.075, weight: .thin))
                    .frame(width: width * 0.1)
                    .foregroundColor(.primary)
            }
            Text("Add to TI Chain").font(.title2)
        }
        .foregroundColor(.primary)
        .padding(.all)
        .fullScreenCover(isPresented: $showFSC) {
            
            ZStack(alignment: .topTrailing) {
                
                // - FSC
                UploadToTIChainFSC(ti: ti, showFSC: $showFSC)
                
                // - Close Button
                Button {
                    showFSC = false
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
                    
                } // Close Button - //
                
            }
        }
    }
}

//MARK: - Enter Description Button
struct EnterDescriptionButton: View {
    
    @Binding var description: String
    var buttonTitle: String = "Enter Video Description"
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        
        Button {
            showSheet.toggle()
        } label: {
            
            Text(buttonTitle).font(.title2)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(lineWidth: 0.5)
                    .foregroundColor(.secondary)
                    .frame(width: width * 0.12, height: width * 0.12)
                
                Image(systemName: "text.alignleft")
                    .font(.system(size: width * 0.07, weight: .light))
                    .foregroundColor(.primary)
                
            }
            .frame(width: width * 0.15, height: width * 0.15)
        }
        .foregroundColor(.secondary)
        .sheet(isPresented: $showSheet) {
            
            // - FSC Title
            VStack {
                Text(buttonTitle)
                    .font(.title)
                    .padding(.all)
                    .foregroundColor(.ADColors.green)
                    .frame(width: width, height: width * 0.1, alignment: .center)
                
                ScrollView {
                    
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: width, height: width * 0.15)
                    
                    ZStack {
                        
                        //FIXME: - BIO from database
                        if description == "" {
                            Text("Enter Post Description")
                                .foregroundColor(.secondary.opacity(0.5))
                                .frame(width: width * 0.85, height: width * 1.3, alignment: .top)
                        }
                        
                        TextEditor(text: $description)
                            .multilineTextAlignment(.leading)
                            .scrollContentBackground(.hidden)
                            .frame(width: width * 0.85, height: width * 1.5, alignment: .top)
                            .submitLabel(.done)
                    }
                }//.padding(.top, width * 0.1)
            }
            .background(Color.black)
            .preferredColorScheme(.dark)
        }
    }
}
