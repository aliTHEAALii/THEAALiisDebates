//
//  DebateCell.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 2/22/23.
//

import SwiftUI

struct DebateCards: View {
    
//    @Binding var showDebateView: Bool
    
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            LazyVStack(spacing: 10) {
//                ForEach(debatesArray, id: \.self) { debate in
                ForEach(0..<5, id: \.self) { i in

                    
                    Button {
//                        chosenDebate = debate
//                        showDebateView.toggle()
                    } label: {
                        VStack() {
//                            DebateFeedCard(debate: debate)
                            Rectangle()
                                .foregroundColor(.gray)
                                .frame(width: width, height: width * 0.5625)
                            
                            //Debate Title & Creator Button
                            HStack(spacing: 0) {
                                Text("Debate Title Here: Meaw vs Rough! Debate")
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.primary)
                                    .frame(width: width * 0.85, alignment: .leading)
                                
//                                UserViewButton(user: debate.debateCreator)
                                Circle()
                                    .frame(width: width * 0.15)
                            }
                        }
                    }
                }
            }
        }
//        .fullScreenCover(isPresented: $showDebateView) {
////            DebateFSC(debate: $chosenDebate, showDebateFSC: $showDebate)
//        }
    }
}

struct DebateCards_Previews: PreviewProvider {
    static var previews: some View {
        DebateCards()
            .preferredColorScheme(.dark)
    }
}
