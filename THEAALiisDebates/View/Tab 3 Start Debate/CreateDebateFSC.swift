//
//  CreateDebateView.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/21/23.
//


//TODO: the border rectangles change color(red/green/gray) if the information provided (wrong/right/none)?

import SwiftUI
import FirebaseStorage

struct CreateDebateFSC: View {
    
    @AppStorage("current_user_id") var currentUserID: String = ""
    
    @Binding var selectedTabIndex: Int
    @Binding var showFullScreenCover: Bool
    
//    @State private var titThumbnailURL: String? = nil
    @State var titThumbnailData: Data? = nil
    @State private var debateTitle              = ""
    @State private var debateDescription        = ""
    
    @ObservedObject private var createTitVM = CreateTITVM()
    @State private var videoURL: String? = nil
    
//    @State private var firstVideoThumbnailURL: String? = nil
    @State var videoThumbnailData: Data? = nil//URL
    @State private var firstVideoTitle       = ""
    @State private var firstVideoDescription = ""
    
    enum Field {
        case debateTitle, debateDescription, videoTitle, videoDescription
    }
    @FocusState private var focusField: Field?
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 10) {
                
                //Tab Title
                StartATITTitleSV()
                
                PickThumbnailSV(thumbnailFor: .TIT, thumbnailForTypeId: createTitVM.TITId, imageData: $titThumbnailData, buttonText: "Pick TIT Thumbnail")
                
                //MARK: - Debate Title
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.13)
                    
                    if debateTitle == "" {
                        Text("TIT Title")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextField("", text: $debateTitle)
                        .multilineTextAlignment(.center)
//                        .scrollContentBackground(.hidden)
                        .frame(width: width * 0.8, height: width * 0.1, alignment: .center)
                        .submitLabel(.done)
                        .focused($focusField, equals: .debateTitle)
                        .onSubmit { focusField = .debateDescription }
                    
                    
                }
                
                //MARK: Debate Description
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.4)
                    
                    //FIXME: - BIO from database
                    if debateDescription == "" {
                        Text("TIT Description")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextEditor(text: $debateDescription)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                        .frame(width: width * 0.85, height: width * 0.4, alignment: .top)
                        .submitLabel(.return)
                        .focused($focusField, equals: .debateDescription)
                        .onSubmit { focusField = .videoTitle }
                }
                .frame(width: width * 0.8, height: width * 0.4, alignment: .top)
                
//                Text("currentUserID::::" + currentUserID)
                
                //MARK: - First Video in Debate INFO

                PickVideoButton(videoURL: $videoURL)

                PickThumbnailSV(thumbnailFor: .video, thumbnailForTypeId: createTitVM.videoId, imageData: $videoThumbnailData, buttonText: "Pick first video Thumbnail")

                //MARK: First Video Title
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.13)
                    
                    if firstVideoTitle == "" {
                        Text("First Video Title")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
//                    TextField(text: $firstVideoTitle)
                    TextField("", text: $firstVideoTitle)
                        .multilineTextAlignment(.center)
//                        .scrollContentBackground(.hidden)
                        .frame(width: width * 0.8, height: width * 0.1, alignment: .center)
                        .submitLabel(.done)
                        .focused($focusField, equals: .videoTitle)
                        .onSubmit { focusField = .videoDescription }
                    
                }
                
                //MARK: First Video Description
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .frame(width: width * 0.9, height: width * 0.4)
                    
                    //FIXME: - BIO from database
                    if firstVideoDescription == "" {
                        Text("First Video Description")
                            .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextEditor(text: $firstVideoDescription)
                        .multilineTextAlignment(.leading)
                        .scrollContentBackground(.hidden)
                        .frame(width: width * 0.85, height: width * 0.35, alignment: .top)
                        .submitLabel(.return)
                        .focused($focusField, equals: .videoDescription)
                        .onSubmit { focusField = nil }
                }
                .frame(width: width * 0.8, height: width * 0.4, alignment: .top)
                
//                Text(currentUserID)
                //MARK: - Create Debate Button
                Button {
                    
                    if createTIButtonText == "Create TIT" {
                        
                        Task {
                            do {
                                let tURL = await ImageManager.shared.saveImage(imageData: titThumbnailData, thumbnailFor: .TIT, thumbnailForTypeId: createTitVM.TITId)
                                let vURL = await ImageManager.shared.saveImage(imageData: videoThumbnailData, thumbnailFor: .video, thumbnailForTypeId: createTitVM.videoId)
                                
                                try await createTitVM.createTIT(
                                    titName: debateTitle, titDescription: debateDescription, titThumbnailURL: tURL,
                                    firstTitVideoName: firstVideoTitle, firstTitVideoDescription: firstVideoDescription, firstVideoThumbnailURL: vURL,
                                    creatorID: currentUserID //"temp"
                                    , firstVideoURL: videoURL!)
//                                try await createTitVM.createTIT(
//                                    titThumbnailData: titThumbnailData, titName: debateTitle, titDescription: debateDescription, titThumbnailURL: nil,
//                                    firstVideoThumbnailData: videoThumbnailData, firstTitVideoName: firstVideoTitle, firstTitVideoDescription: firstVideoDescription,
//                                    creatorID: "currentUserUID", firstVideoURL: videoURL!)
                                
                                selectedTabIndex = 4
                                showFullScreenCover = false
                                
                                debateTitle = ""
                                debateDescription = ""
                                firstVideoTitle = ""
                                firstVideoDescription = ""
                            } catch {
                                print("👺👹🤬 Error: Counl't upload tit")
                            }
                        }
                        
                        
//                        uploadedVideoID = nil
                    }
                    
                } label: {
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .frame(width: width * 0.9, height: width * 0.2)
                            .foregroundColor(createTIButtonText == "Create TIT" ? .ADColors.green : .secondary.opacity(0.5))
                        
                        
                        Text(createTIButtonText)
                            .foregroundColor(createTIButtonText == "Create TIT" ? .ADColors.green : .primary)
                            .font(createTIButtonText == "Create TIT" ? .title : .body)
                        
                    }
                    .padding(.top)
                    .foregroundColor(.primary)
                    .frame(width: width * 0.8, height: width * 0.2, alignment: .top)
                }
                
//                Spacer()
            }
            .foregroundColor(.primary)
            .preferredColorScheme(.dark)
            .onTapGesture { focusField = nil }
        }
    }
    
    //MARK: - Functions
    var createTIButtonText: String {
        if debateTitle == "" {
            return("Provide TIT Title")
        } else if debateDescription == "" {
            return("Provide TIT Description")
//        } else if firstVideoURL == nil {
        } else if videoURL == nil {
            return("Provide the First Video for the Debate")
        } else if firstVideoTitle == "" {
            return("Provide Video Title")
        } else if firstVideoDescription == "" {
            return("Provide Video Description")
        } else {
            return "Create TIT"
        }
    }
}

struct CreateDebateFSC_Previews: PreviewProvider {
    static var previews: some View {
//        CreateDebateFSC(selectedTabIndex: .constant(2), showFullScreenCover: .constant(true), videoID: "k")
        CreateDebateFSC(selectedTabIndex: .constant(2), showFullScreenCover: .constant(true))

    }
}

struct StartATITTitleSV: View {
    
    var leftText = "Create"
    var rightText = "T. I."
    
    var body: some View {
        HStack(spacing: 0) {
            
            Text(leftText)
                .font(.system(size: width * 0.08, weight: .light))
                .foregroundColor(.ADColors.green)
                .frame(width: width * 0.3, alignment: .trailing)
            
            Image(systemName: "triangle")
                .font(.system(size: width * 0.08, weight: .light))
                .foregroundColor(.ADColors.green)
                .frame(width: width * 0.2)
            
            
            Text(rightText)
                .font(.system(size: width * 0.08, weight: .light))
                .foregroundColor(.ADColors.green)
                .frame(width: width * 0.3, alignment: .leading)
            
        }
        .frame(width: width * 0.8)
    }
}
