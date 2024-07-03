//
//  DebateView.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/22/23.
//

import SwiftUI

struct TITView: View {
    
    //FIXME: - FIX This Line
    @State var TIT : TIModel? = TestingModels().testingTIModel
    @AppStorage("tit_id") var TITid: String = ""
    
    @ObservedObject private var vmTIT = TITViewModel()
    
    @Binding var showDebateView: Bool
    @Binding var isMiniPlayer: Bool
    
    @State private var offset = CGSize.zero
    @State private var offsetNumber = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 0) { //spacing: 5
            
            //Video & Mini Player HStack
            HStack(spacing: 0) {
                ZStack {
                    
                    //MARK: VIDEO
                    VideoSV(urlString: vmTIT.videoURL)

                    
                    if isMiniPlayer {
                        Button {
                            isMiniPlayer = false
                            self.offset = .zero
                            offsetNumber = 0 ///
                        } label: {
                            Image(systemName: "triangle.fill")
                        }
                    }
                }
                .frame(width: isMiniPlayer ? width * 0.4 : width,
                       height: isMiniPlayer ? (width * 0.5625 * 0.4) : width * 0.5625)
                .onTapGesture {
                    if isMiniPlayer {
                        isMiniPlayer = false
                        self.offset = .zero
                        offsetNumber = 0 ///
                    }
                }
                
                //MARK: Is Mini Player
                if isMiniPlayer {
                    
                    HStack(spacing: 0) {
                        
                        Button {
                            isMiniPlayer = false
                            self.offset = .zero
                            offsetNumber = 0 ///
                            
                        } label: {
                            Text("video title")
                                .frame(width: width * 0.4)
                        }
                                                
                        //Pause Button
                        Button {
                            
                        } label: {
                            Image(systemName: "pause")
                                .frame(width: width * 0.15)
                        }
                                                
                        //Close Button
                        Button {
                            isMiniPlayer = false
                            showDebateView = false
                            self.offset = .zero
                            offsetNumber = 0 ///

                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: width * 0.15)
                            
                        }
                    }
                    .frame(height: width * 0.15) ////Here
                    
                }
                
            }
            .frame(alignment: .leading)
            .background(.black)
            //            .padding(.top, isMiniPlayer ? height - width * 0.55 : 0)
            //            .frame(height: height - width * 0.1, alignment: .bottom)
            //            .padding(.top, isMiniPlayer ? height - width * 0.6 : 0)
            
            //tabs bar is (width * 0.15)
            //miniPlayer is (width * 0.4)
            
            ///------------
            //MARK: - Not mini Player (SVs)
            if !isMiniPlayer { ///--
                
                ScrollView(showsIndicators: false) {
                    
                    DebateControlsSV()
                    
                    //TODO: - Takes The Link
                    //TODO: current Index
//                    VideoInfoSV(tit: <#TITModel#>, titVideo: <#TITVideoModel#>)
                    //TODO: current Index
                    ResponseArrayTopBarSV(tiID: TITid, chainLID: "testing") //FIXME: herererere
                    
                    ForEach(0..<5, id: \.self) { i in
                        VotingCell()
                    }
                }.background(Color.black)
            }///---
            
        }//VStack
        .frame(height: isMiniPlayer ? width * 0.15 : nil)
        //        .frame(height: isMiniPlayer ? (width * 0.5625 * 0.4) : nil)
        .preferredColorScheme(.dark)
        .offset(x: 0, y: offset.height)
        //MARK: - on Appear
        .onAppear{

            Task {
                do {
                    try await vmTIT.getTIT(titId: (TITid))
                    try await vmTIT.getCLink()
                } catch TITError.serverError {
//                    vmTIT.error = error
                }

            }
        }
        //MARK: - Drag
        .gesture(
            DragGesture()
            //on change
                .onChanged { value in
                    
                    if !isMiniPlayer {
                        self.offset = value.translation
                    }
                    
                    if offset.height > height * 0.2 {
                        withAnimation(.spring()) {
                            isMiniPlayer = true
                            self.offset = .zero
                        }
                        
                    }
                    
                    offsetNumber = Int(offset.height)
                    
                }
                .onEnded({ _ in
                    
                    if !isMiniPlayer {
                        self.offset = CGSize.zero
                    }
                })
        )
    }
}

//struct TITView_Previews: PreviewProvider {
//    static var previews: some View {
//
////        TabsBarCustomized()
//        TITView(TIT: TestingComponents().testingTIT, showDebateView: .constant(true), isMiniPlayer : .constant(false))
//    }
//}

//#Preview {
//    TITView(TIT: TestingComponents().testingTIT, showDebateView: .constant(true), isMiniPlayer : .constant(true))
//}

