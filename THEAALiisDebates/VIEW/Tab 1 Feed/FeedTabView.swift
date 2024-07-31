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
    
    //John Gallaugher
//    @FirestoreQuery(collectionPath: "THEAALii_Interactions") var interactionsFeed: [TI]
    @State var interactionsFeed: [TI] = []


    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            //Intro Video: How to use the app //
//            Rectangle()
//                .fill(.gray)
//                .frame(width: width, height: width * 0.5625)
//            
//            Text("THEAALii's Interaction Technology (TI)\n Tutorial")
//                .font(.title2)
//                .multilineTextAlignment(.center)
            // ------------ //
            
            
            Divider()
            
            
            //Interactions Feed
            //FIXME: LazyVStack & @FiretoreQuery
            ///FSQ grabs everything in the db.
            ///when LazyVStack updates forEach doesn't get the added stuff
            ///
//            LazyVStack {
                ForEach(interactionsFeed, id: \.id) { ti in

                    // Log the title of each TI

                    TiCard(ti: ti)
                    
//                        TiCard(ti: ti)
//                        .onAppear {
//                            print("🐙☘️Rendering TiCard for title: \(ti.id)💥🥬")
//
////                            print("🐙☘️Rendering TiCard for title: \(ti.title)💥🥬")
////                            print("😅 \(interactionsFeed) 😄")
//                        }
                    
                }
//            }
            
            Rectangle()
                .foregroundStyle(.white.opacity(0))
                .frame(width: width, height: width * 0.5)

        }
        .preferredColorScheme(.dark)
        .onAppear{ Task { await onAppearFetch() } }
        .refreshable { Task { await onAppearFetch() }  }

    }
    
    //MARK: - function
    func onAppearFetch() async {
        do {
            let querySnapshot = try await Firestore.firestore()
                .collection("THEAALii_Interactions")
//                .whereField("ti_type", isEqualTo: "D-1") // Add condition
                .order(by: "ti_absolute_votes", descending: true) // Sort by field
                .getDocuments()
            
            let fetchedInteractions = querySnapshot.documents.compactMap { document in
                try? document.data(as: TI.self)
            }
            
            print("🟢 Fetched Interactions")
            interactionsFeed = fetchedInteractions
            
        } catch {
            print("❌Error fetching interactions: \(error)❌")
            return
        }
    }

}

struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        //        FeedTabView2(showDebateView: .constant(false))
        //            .environmentObject(DataManagerVM())

        FeedTabView()
//        RootView(logStatus: true)
//        FeedTabView(showTITView: .constant(false))
        //            .environmentObject(DataManagerVM())


    }
}



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

//MARK: - TiCard
struct TiCardOld: View {
    
    var ti: TI
    
    @State private var showTiView: Bool = false
    
    var body: some View {
        
        
        Button{
            showTiView.toggle()
        } label: {
            
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    
                    //Image
                    VStack {
                        //TODO: if thumbnail url is nil
                        if let thumbnailURL = ti.thumbnailURL {
                            AsyncImage(url: URL(string: thumbnailURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: width, height: width * 0.5625)
                                
                            } placeholder: {
                                LoadingView()
                                    .frame(width: width, height: width * 0.5625)
                            }
                        } else {
                            
                        }
                        
                        //Bottom area (for the height of the ZStack
                        Rectangle()
                            .foregroundStyle(.white.opacity(0))
                            .frame(height: ti.tiType == .d1 ? width * 0.125 : width * 0.125)
                    }
                    
                    //Ti Icon
                    if ti.tiType == .d1 {
                        //                    TIIconD1(scale: 1.2, showTiIcon: false)
                        RoundedRectangle(cornerRadius: 8)
                            .trim(from: 0, to: 0.5)
                            .stroke(lineWidth: 1 )
                            .offset(y: width * -0.04 )
                            .frame(width: width * 0.66, height: width * 0.2)
                            .foregroundColor(.primary)
                        
                    } else if ti.tiType == .d2 {
                        TIIconD2(showTwoSides: false)
                        
                    }
                    
                    
                    
                    //Users
                    HStack(alignment: .bottom) {
                        if ti.tiType == .d2 {
                            UserButton(userUID: ti.lsUserUID)
                                .padding(.horizontal, width * 0.005)
                        }
                        
                        Spacer()
                        
                        UserButton()
                            .padding(.horizontal, width * 0.005)
                    }
                    .frame(width: width, height: width * 0.15)
                }//ZStack
                
                //Ti Title
                Text(ti.title)
                    .foregroundStyle(.white, .white)
                    .frame(width: width * 0.97, alignment: ti.tiType == .d1 ? .center : .center )
                    .multilineTextAlignment(ti.tiType == .d1 ? .center : .center)
                    .padding(.top, width * 0.03)
                    .padding(.bottom)
            }
            
        }
        //MARK: Ti FSC
        .fullScreenCover(isPresented: $showTiView) {
            TiView(ti: ti, showTiView: $showTiView)
        }
    }
}
