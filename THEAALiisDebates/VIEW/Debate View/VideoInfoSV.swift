//
//  VideoInfoSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/28/23.
//

import SwiftUI

//@MainActor
//final class VideoInfoViewModel: ObservableObject {
//
//    @Published var TITvideo: TITVideoModel
//
//    init() {
//        TITvideo = TITVideoModel(id: "mea2", videoURL: "",
//                                 thumbnail: "",
//                                 creatorID: "creator",
//                                 name: "Testing TIT Video 1",
//                                 description: "This TIT Video is for testing purposes only"
//        )
//    }
//}

/*
 The controls for the video in the chain are all here.
 and are controlled from here
 */
struct VideoInfoSV: View {
    
//    @StateObject var vm = VideoInfoViewModel()
    //FIXME: This Line
//    var video: TITVideoModel = TestingComponents().titVideo1
    
    ///
//    @ObservedObject var titVM2 = TITViewModel()
    ///
    var tit: TIModel
    var tiVideo: TIVideoModel?
    
    @State private var showSideOptions = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
//            if let titVideo = titVideo {
                if let tiVideo = tiVideo {

                //            Text(vm.TITvideo.name)
                //1. video title
                Text(tiVideo.name)
                    .font(.title2)
                    .frame(width: width, height: width * 0.2)
                
                //2. Description & Buttons
                ZStack {
                    HStack(spacing: 0) {
                        
//                        DescriptionSV(descriptionTitle: "Video Description", text: vm.TITvideo.description)
                        DescriptionSV(descriptionTitle: "Video Description", text: tiVideo.description)
                        
                        // - Video Buttons
                        VStack(spacing: 0) {
                            
                            //Video Creator
//                            UserButton(userID: vm.TITvideo.creatorID, imageURL: "")
                            UserButton(userUID: tiVideo.creatorID
//                                       , imageURL: ""
                            )
                            
                            //Comments
                            CommentsButton()
                            //Side Expand
                            //                        SideOptionsExpandButton(showOptions: $showSideOptions)
                            //                        .frame(width: width * 0.15, height: width * 0.15)
                            
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(width: width * 0.15, height: width * 0.15)
                            
                        }
                        .frame(width: width * 0.15, height: width * 0.45)
                    }
                    
                    // - Side Sheet (Don't Delete)
                    //                SideOptionsSheet(showSideSheet: $showSideOptions)
                    //                    .offset(x: showSideOptions ? width * 0.375 : width * 0.68)
                    SideSheet()
                }
            } else {
//                ProgressView()
                ZStack {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                        .frame(width: width, height: width * 0.65)
                    ProgressView()
                }
            }
        }
        .background(Color.black)
//        .onAppear{ Task { titVM.getTiVideo(titId:videoId:) } }
    }
}
//MARK: Preview
//struct VideoInfoSV_Previews: PreviewProvider {
//    static var previews: some View {
//        TITView(showDebateView: .constant(true), isMiniPlayer : .constant(false))
//    }
//}

//MARK: - Side Options Expand Button 2
struct SideOptionsExpandButton2: View {
    
    @Binding var showOptions: Bool
    var sizeFactor: CGFloat = 1.5
    
    var body: some View {
        
        Button {
            showOptions.toggle()
        } label: {
            
            ZStack {
                //                Image(systemName: "chevron.left")
                //                    .font(.system(size: width * 0.085 * sizeFactor, weight: .ultraLight))
                //                    .frame(width: width * 0.15 * sizeFactor, height: width * 0.15 * sizeFactor)
                
                //                Image(systemName: "ellipsis")
                //                    .rotationEffect(Angle(degrees: 90))
                //                    .offset(x: 13)
                //                    .font(.system(size: width * 0.08, weight: .light))
                //                    .frame(width: width * 0.15, height: width * 0.15)
                
                VStack(spacing: 3) {
                    
                    Circle()
                        .strokeBorder(lineWidth: 1)
                    Circle()
                        .strokeBorder(lineWidth: 1)
                    Circle()
                        .strokeBorder(lineWidth: 1)
                    
                }
                .frame(height: width * 0.075 * sizeFactor)
                
                .offset(x: 18)
                
            }
            .foregroundColor(.secondary)
            .frame(width: width * 0.15, height: width * 0.15)
        }
        
    }
}

//MARK: - Side Options Expand Button
struct SideOptionsExpandButton: View {
    
    @Binding var showOptions: Bool
    var sizeFactor: CGFloat = 1.5
    
    var body: some View {
        
        Button {
            withAnimation(.spring()) {
                showOptions.toggle()
            }
            //            showOptions.toggle()
        } label: {
            
            Image(systemName: "chevron.left.circle")
                .font(.system(size: width * 0.07 * sizeFactor, weight: .thin))
                .foregroundColor(.secondary)
                .frame(width: width * 0.15, height: width * 0.15)
        }
    }
}

