//
//  CreateTI.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/6/24.
//

import SwiftUI

struct CreateTI: View {
    
    @AppStorage("current_user_id") var currentUserUID: String = ""
    //TI
    let tiId = UUID().uuidString
    @State private var tiInteractionType: TIType? = nil

    @State private var tiThumbnailData: Data? = nil
    @State private var tiTitle              = ""
    @State private var tiDescription        = ""
    
    //VS TI
    @State private var leftUser : String?    = nil
    @State private var rightUser: String?   = nil
    
    //INTRO Video
    @State private var introUnitType: PostType = .video
    let introVideoId = UUID().uuidString
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
    
    let steps = ["TI Type", "Interaction Info", "Admins", "Intro Post Info"]
    @State var indexStep = 0
    
    //MARK: View
    var body: some View {
        
        VStack {
            
            //Top bar
            HStack(spacing: 0) {
                Text("Create a THEAALii Interaction")
                    .font(.title2).foregroundColor(.ADColors.green)
                    .frame(width: width * 0.85, height: width * 0.15)
                
                //Close Button
                Button {
                    Task {
//                        isLoading.toggle()
                        closeButtonPressed()
//                        showFSC.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: width * 0.1, weight: .thin))
                        .foregroundColor(.primary)
                        .frame(width: width * 0.15)
                }
            }// top bar - //
//            CloseButton(showFSC: <#T##Binding<Bool>#>)
            
            //Step Indicators
            HStack(spacing: 20) {
                ForEach(0..<5) { i in
                    
                    Button {
                        indexStep = i
                    } label: {
                        ZStack {
                            Circle()
                                .stroke()
                                .frame(width: width * 0.125)//, height: width * 0.1)
                            
                            Text("\(i + 1)")
                        }
                        .foregroundStyle(indexStep == i ? Color.ADColors.green : .white)
                    }
                }
            }.frame(width: width, height: width * 0.08)
                .padding(.bottom, width * 0.1)
            
            //Title
//            Text( steps[indexStep] )
//                .font(.title)
//                .padding(.vertical)
            
            
            //
            if indexStep == 0 {
                SelectTiTypeSV(tiInteractionType: $tiInteractionType)
            } else if indexStep == 1 {
                //MARK: TI Thumbnail
//                HStack(spacing: 0) {
//                    
//                    if tiInteractionType == .d2 {
//                        if leftUser == nil {
//                            Button {
//                                
//                            } label: {
//                                PersonTITIconSV(color: .red, scale: 1.5)
//                                    .padding(.leading, width * 0.05)
//                                    .frame(width: width * 0.3, alignment: .leading)
//                            }
//                            
//                        } else{
//                            UserButton(userID: nil)
//                                .padding(.leading)
//                                .frame(width: width * 0.3, alignment: .leading)
//                        }
//                    }
//                    
//                    PickThumbnailButton(thumbnailFor: .TI, thumbnailForTypeID: tiId, imageData: $tiThumbnailData, buttonText: "TI \nThumbnail")
//                    
//                    if tiInteractionType == .d2 {
//                        if leftUser == nil {
//                            Button {
//                                
//                            } label: {
//                                PersonTITIconSV(color: .red, scale: 1.5)
//                                    .padding(.trailing, width * 0.05)
//                                    .frame(width: width * 0.3, alignment: .trailing)
//                            }
//                            
//                        } else {
//                            UserButton(userID: nil)
//                                .padding(.trailing)
//                                .frame(width: width * 0.3, alignment: .trailing)
//                        }
//                    }
//                }
//                AddD1Info(tiID: tiId,
//                          tiInteractionType: $tiInteractionType,
//                          thumbnailForTypeID: tiId)
                AddD1Info(tiID: tiId, tiInteractionType: $tiInteractionType, tiThumbnailData: $tiThumbnailData, thumbnailForTypeID: tiId, tiTitle: $tiTitle, rightUser: $rightUser)
                //                .padding(.top)
            } else if indexStep == 2 {
                
            } else if indexStep == 3 {
                
            } else if indexStep == 4 {
                
            }

            
            
            
            Spacer()
            
            //Next Step Button
            Button {
                if indexStep < 4 { indexStep += 1 }
            } label: {
                ZStack {
                    Text(nextStepText())
                    
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .frame(width: width * 0.8, height: width * 0.15)
                }
                .foregroundStyle(Color.ADColors.green)
            }
            .padding(.vertical, width * 0.1)
        }
    }
    
    //MARK: - Functions
    private func closeButtonPressed() {
        isLoading = true
        
        selectedTabIndex = 0
        isLoading = false
        showFSC = false
    }
    
    private func nextStepButton() {
        
    }
    private func nextStepText() -> String {
        if indexStep == 0 && tiInteractionType == nil { return "Select TI Type"}
//        else if
        
        return "Next Step"
    }
}

#Preview {
    CreateTI(showFSC: .constant(true), selectedTabIndex: .constant(0))
}

