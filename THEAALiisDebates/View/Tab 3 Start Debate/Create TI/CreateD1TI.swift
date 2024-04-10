//
//  CreateD1TI.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 6/10/23.
//

import SwiftUI

struct CreateD1TI: View {
    
    @AppStorage("current_user_id") var currentUserUID: String = ""
    //TI
    let tiID: String
    @Binding var interactionType: TIType

    @Binding var tiThumbnailData: Data?
    @Binding var tiTitle: String
    @Binding var tiDescription: String
    
    //VS TI
    @State private var leftUser: String?    = nil
    @State private var rightUser: String?   = nil

    
    //INTRO Video
    @State private var introUnitType: PostType = .video
    let introVideoID = UUID().uuidString
    @State private var introVideoThumbnailData: Data? = nil
    @State private var introVideoURL: String? = nil
    @State private var introVideoTitle              = ""
    @State private var introVideoDescription        = ""

    enum Field {
        case debateTitle, debateDescription, videoTitle, videoDescription
    }
    @FocusState private var focusField: Field?
    
    @Binding var showFSC: Bool
    @Binding var selectedTabIndex: Int
    
    @State private var isLoading = false
    
    //MARK: - View
    var body: some View {


        ScrollView(showsIndicators: false) {
            VStack(spacing: width * 0.02) {

                //MARK: TI Thumbnail
                HStack(spacing: 0) {
                    
                    if interactionType == .d2 {
                        if leftUser == nil {
                            Button {
                                
                            } label: {
                                PersonTITIconSV(color: .red, scale: 1.5)
                                    .padding(.leading, width * 0.05)
                                    .frame(width: width * 0.3, alignment: .leading)
                            }
                            
                        } else{
                            UserButton(userID: nil)
                                .padding(.leading)
                                .frame(width: width * 0.3, alignment: .leading)
                        }
                    }
                    
                    PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiID, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
                    
                    if interactionType == .d2 {
                        if leftUser == nil {
                            Button {
                                
                            } label: {
                                PersonTITIconSV(color: .red, scale: 1.5)
                                    .padding(.trailing, width * 0.05)
                                    .frame(width: width * 0.3, alignment: .trailing)
                            }
                            
                        } else {
                            UserButton(userID: nil)
                                .padding(.trailing)
                                .frame(width: width * 0.3, alignment: .trailing)
                        }
                    }
                }
                .padding(.top)
                
                
                //MARK: TI Title
                ZStack {
                    //Border
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .foregroundColor(tiTitle != "" ? .primary : .red)
                        .frame(width: width * 0.9, height: width * 0.13)
                    
                    if tiTitle == "" {
                        Text("TI Title")
//                                .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextField("", text: $tiTitle)
                        .multilineTextAlignment(.center)
                        .frame(width: width * 0.8, height: width * 0.1, alignment: .center)
                        .submitLabel(.done)
                        .focused($focusField, equals: .debateTitle)
                        .onSubmit { focusField = .debateDescription }
                }
                
                //TI Description
                EnterDescriptionButton(description: $tiDescription, buttonTitle: "TI description")
                    .frame(width: width * 0.9, height: width * 0.125)
                
                Divider()
                
                //MARK: - Intro Video
                
                //Pick type
                HStack(spacing: width * 0.05) {
                    
                    Text("Intro Type:")
                        .foregroundColor(.secondary)
                    
                    Button {
                        introUnitType = .text
                    } label: {
                        ZStack {
                            if introUnitType == .text {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                            }
                            Text("Text")
                        }
                        .frame(width: width * 0.15, height: width * 0.1)
                    }

                    
                    Button {
                        introUnitType = .video
                    } label: {
                        ZStack {
                            if introUnitType == .video {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                            }
                            Text("Video")
                        }
                        .frame(width: width * 0.15, height: width * 0.1)
                    }
                    
                    Button {
                        introUnitType = .image
                    } label: {
                        ZStack {
                            if introUnitType == .image {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                            }
                            Text("Image")
                        }
                        .frame(width: width * 0.15, height: width * 0.1)
                    }
                }
                .foregroundColor(.primary)
                .frame(height: width * 0.15)
                
                HStack {
                    
                    Spacer()
                    
                    PickThumbnailButton(thumbnailFor: .video, thumbnailForTypeID: introVideoID, imageData: $introVideoThumbnailData, buttonText: "Intro Video \nThumbnail")
                    
                    Spacer()
                    
                    ZStack {
                        //Border
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 0.5)
                            .foregroundColor(introVideoURL != nil ? .primary : .red)
                            .frame(width: width * 0.4, height: width * 0.5625 * 0.4)
                        
                        Text("Intro Video")
                            .font(.title2)
                    }
                    
                    Spacer()
                }
                
                //MARK: Intro Video Title
                ZStack {
                    //Border
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(lineWidth: 0.5)
                        .foregroundColor(introVideoTitle != "" ? .primary : .red)
                        .frame(width: width * 0.9, height: width * 0.13)
                    
                    if introVideoTitle == "" {
                        Text("Intro Video Title")
//                                .foregroundColor(.secondary.opacity(0.5))
                    }
                    
                    TextField("", text: $introVideoTitle)
                        .multilineTextAlignment(.center)
                        .frame(width: width * 0.8, height: width * 0.1, alignment: .center)
                        .submitLabel(.done)
                        .focused($focusField, equals: .debateTitle)
                        .onSubmit { focusField = .debateDescription }
                }
                
                EnterDescriptionButton(description: $introVideoDescription, buttonTitle: "Intro Video description")
                    .frame(width: width * 0.9, height: width * 0.125)

                //MARK: Create TI Button
                Button {
                    if createTIButtonText == "Create TI" {
                        Task { try await createTID1() }
                    }
                } label: {
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 0.5)
                            .frame(width: width * 0.9, height: width * 0.2)
                            .foregroundColor(createTIButtonText == "Create TI" ? .ADColors.green : .secondary.opacity(0.5))
                        
                        
                        Text(createTIButtonText)
                            .foregroundColor(createTIButtonText == "Create TI" ? .ADColors.green : .primary)
                            .font(createTIButtonText == "Create TI" ? .title : .body)
                        
                    }
//                        .padding(.top)
                    .foregroundColor(.primary)
                    .frame(width: width * 0.8, height: width * 0.2, alignment: .top)
                }

            }
        }
            .preferredColorScheme(.dark)
    }
    
    //MARK: - Functions -
    var createTIButtonText: String {
        if tiTitle == "" {
            return("Provide TI Title")
        } else if tiThumbnailData == nil {
            return("Provide TI Thumbnail")
//        } else if introVideoURL == nil {
        } else if introVideoURL == nil {
            return("Provide the Intro Video")
        } else if introVideoTitle == "" {
            return("Provide Intro Video Title")
//        } else if introVideoDescription == "" {
//            return("Provide Video Description")
        } else {
            return "Create TI"
        }
    }
    
    private func createTID1() async throws {
        Task {
            let tiThumbnailURL = await ImageManager.shared.saveImage(imageData: tiThumbnailData, thumbnailFor: .TIT, thumbnailForTypeId: tiID)
            
            let PostThumbnailURL = await ImageManager.shared.saveImage(imageData: tiThumbnailData, thumbnailFor: .TI, thumbnailForTypeId: tiID)
        }
        selectedTabIndex = 4

    }
}

struct CreateD1TI_Previews: PreviewProvider {
    static var previews: some View {
        
        CreateTIFSC(showFSC: .constant(true), selectedTabIndex: .constant(2))

        CreateD1TI(tiID: "tiID", interactionType: .constant(.d1), tiThumbnailData: .constant(nil), tiTitle: .constant(""), tiDescription: .constant("ti desc"), showFSC: .constant(true), selectedTabIndex: .constant(2))
    }
}
