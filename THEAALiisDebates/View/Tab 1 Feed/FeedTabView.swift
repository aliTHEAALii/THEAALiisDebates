//
//  FeedTabView.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 1/9/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct FeedTabView: View {
    
    //MARK: - John Gallaugher
    @FirestoreQuery(collectionPath: "Interactions") var interactionsFeed: [TIModel]
    
    @Binding var showTITView: Bool
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            //Intro Video: How to use the app
            Rectangle()
                .fill(.gray)
                .frame(width: width, height: width * 0.5625)
            
            Text("THEAALii's Interaction Technology (TIT)\n Tutorial")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Divider()
            
            //Interactions Feed
            LazyVStack {
                ForEach(interactionsFeed, id: \.id) { interaction in
                    
                    TITCard(showTITView: $showTITView,
                            debateID: interaction.id,
                            debateName: interaction.name,
                            TIT: interaction)
                }
            }
        }
        .preferredColorScheme(.dark)
        //TODO: Refreshable
        .refreshable {
            @FirestoreQuery(collectionPath: "Interactions") var interactionsFeed: [TIModel]

        }
    }
}

//struct FeedTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        FeedTabView2(showDebateView: .constant(false))
//        //            .environmentObject(DataManagerVM())
//
//        FeedTabView(showTITView: .constant(false), TIT: .constant(TestingComponents().testingTIT))
//        //            .environmentObject(DataManagerVM())
//
//
//    }
//}



//struct FeedTabView2: View {
//
//    @ObservedObject var dataManager: DataManagerVM
//
//    @Binding var showDebateView: Bool
//
//    var body: some View {
//
//        ScrollView(showsIndicators: false) {
//
//            //Intro Video (Debate) How to use the app
//            Rectangle()
//                .fill(.gray)
//                .frame(width: width, height: width * 0.5625)
//            Text("Intro to the app")
//                .font(.title)
//
//            Text(" \(dataManager.debates.count)")
//            //Debates
//            LazyVStack {
////                ForEach(0..<1, id: \.self) { interaction in
//                ForEach(dataManager.debates, id: \.id) { interaction in
//
//
//                    Text("here")
////                    VideoCard()
//                    DebateCard(showDebateView: $showDebateView, debateName: interaction.name)
////                    DebateCard(showDebateView: $showDebateView, debateName: interaction.name)
//                }
//            }
//        }
//
//        .preferredColorScheme(.dark)
//    }
//}
