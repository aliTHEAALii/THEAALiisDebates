//
//  MiniPlayer.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/11/23.
//

import SwiftUI

//MARK: - Mini
struct MiniPlayer: View {
    
    @State private var offset = CGSize.zero
    @State var isMiniPlayer = false
    
    @State private var offsetNumber = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            //Video & Mini Player HStack
            HStack(spacing: 0) {
                ZStack {
                    
//                    VideoPlayerView()
                    Rectangle()
                        .foregroundColor(.secondary)
                        .frame(width: width, height: width * 0.5625)
                    
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

//                        Divider()
                        
                        //Pause Button
                        Button {
                            
                        } label: {
                            Image(systemName: "pause")
                                .frame(width: width * 0.15)
                        }
                        
                        Divider()

                        //Close Button
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: width * 0.15)

                        }
                    }

                }

            }
            .background(.black)
            .frame(alignment: .leading)
            //MARK: - Padding
            .padding(.top, isMiniPlayer ? height - width * 0.55 : 0)
            //tabs bar is (width * 0.15)
            //miniPlayer is (width * 0.4)
            
            //MARK: IsNOT Mini Player
            if !isMiniPlayer {
                HStack {
                    Text("\(isMiniPlayer ? "true" : "false") \(offsetNumber)")
                        .padding()
                }
                .frame(width: width)
                .background(.black)

                
                ScrollView {
                    ForEach(0...1, id: \.self) { _ in

                        Rectangle()
                            .frame(height: width * 0.3)
                            .foregroundColor(.gray)
                    }
                }
                .background(.black)

                
            }
            
        }//VStack
        .offset(x: 0, y: offset.height)
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
                    
                    offsetNumber = Int(offset.height)///
                    
                }
            //on Ended
                .onEnded({ _ in
                    
                    if !isMiniPlayer {
                        self.offset = CGSize.zero
                    }
                })
        )
        
    }
}

struct MiniPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayer()
    }
}
