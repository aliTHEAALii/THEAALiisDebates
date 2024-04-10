//
//  VideoCard.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 1/9/23.
//

import SwiftUI

struct VideoCard: View {
    
    @State var showDebateView = false
    
    let text2 = " Intro to the app what the f is going on here man, woman, other creatures. what is going on here? you must answer"
    let text3 = " Intro to the app what the f is"
    let text = " Intro to the app what the f is going on here man, woman, other creatures."
    
    var body: some View {
        
        VStack(spacing: 0){
            
            Button {
                showDebateView.toggle()
                
            } label: {
                Rectangle()
                    .fill(.gray)
                    .frame(width: width, height: width * 0.5625)
                
            }
            
            HStack(spacing: 0) {
                if text.count < 50 {
                    
                    Text(String(text.count) + text)
                        .font(.body)
                        .padding(.horizontal, 10)
                        .frame(width: width * 0.85, alignment: .leading)
                    
                } else {
                    
                    Text(String(text.count) + text)
                        .font(.body)
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.leading)
                        .frame(width: width * 0.85, height: width * 0.2)

                }
                
                //User Button
                ZStack(alignment: .center) {
                    
                    Button {
                        
                    } label: {
                        Circle()
                            .frame(width: width * 0.1)
                    }
                    
                }
                .frame(width: width * 0.15, height: width * 0.1)
            }
            .frame(width: width)
        }
        .fullScreenCover(isPresented: $showDebateView) {
            TITView(TIT: TestingComponents().testingTIT, showDebateView: .constant(true), isMiniPlayer : .constant(false))
        }
        
    }
}

struct VideoCard_Previews: PreviewProvider {
    static var previews: some View {
        
        TabsBarCustomized()
        
        FeedTabView(showTITView: .constant(false))
        
        VideoCard()
            .preferredColorScheme(.dark)

    }
}
