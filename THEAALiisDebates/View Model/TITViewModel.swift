//
//  TITManagerVM.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/31/23.
//

//import Foundation
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

@MainActor
final class TITViewModel: ObservableObject {
    
    @Published var TIT: TIModel?
    @Published var chainIndex: Int = 0
    @Published var titVideo: TIVideoModel?
    @Published var showTIT: Bool = false
    @Published var error: Error?
    @Published var videoURL: String = "" //Delete
    
    
    init() {
        
        print("🦠🧬🤬😈 Entered get TIT 😈🤬🧬🦠")

        ///TITView is set to the tutorial by default.
//        TIT = TITModel(
//            id: "BD1DC9C0-4FA7-468F-8E51-8EC42784323B",
//            name: "THEAALii's Interaction Technology (TIT)\n Tutorial",
//            description: "Welcome to THEAALii Debates.",
//            thumbnailURLString: nil,
//            creatorUID: "f2i3iO0pSWWn11WlkXrf0gILwyw2",
//            administratorsUID: []
////            interactionChain: ["testingChainLink1"]
//        )
    }
    
    //MARK: get TIT
    func getTIT(titId: String?) async throws {
        
        print("🦠🧬🔗⬇️ Entered get TIT XXXXXX⬇️🔗🧬🦠" + (TIT?.id ?? "nil"))

        do {
            guard let titId = titId else { throw TITError.nilTIT }
            print("🦠🧬🔗⬇️ Entered get TIT do ⬇️🔗🧬🦠")

            self.TIT = try await TITManager.shared.getTIT(TITid: titId)
            print("🦠🧬🔗📄 !set! 📄🔗🧬🦠" + (TIT?.id ?? "nil"))
            print("🦠🧬🔗📄 Entered get TIT XXXXXX📄🔗🧬🦠" + (TIT?.id ?? "nil"))

            

            showTIT = true
        } catch TITError.serverError {
            print("❌🧬⬇️ Error: getting TIT [ TITVM.getTIT() ] ⬇️🧬❌")
            self.error = error
        }
    }

    //get Chain Link
    func getCLink() async throws {
        guard let TIT = TIT else {
            print("❌🧬 TIT Error: TIT doesn't exist")
            throw TITError.nilTIT
        }
        do {
//            print("🦠🧬🔗⬇️ got chain count 🧬 TIT ⬇️🔗🧬🦠" + String(TIT.interactionChain.count))
//            print(TIT)

            let chainLinkId: String = TIT.interactionChain[chainIndex]
//            print("🦠🧬🔗⬇️ got 1 ⬇️🔗🧬🦠")
            
            let chainLink = try await TITChainLinkManager.shared.getTitChainLink(TITid: TIT.id, titChainID: chainLinkId)
//            print("🦠🧬🔗⬇️ got 2 ⬇️🔗🧬🦠")

//            let videoId = chainLink.videoID
            let titVideo = try await TITVideoManager.shared.getTITVideo(TITid: TIT.id, TITVideoID: chainLink.videoID)
//            print("🦠🧬🔗⬇️ got 3 ⬇️🔗🧬🦠")

            self.titVideo = titVideo
            self.videoURL = titVideo.videoURL
            print("🦠🧬🔗⬇️ got TITVideo ⬇️🔗🧬🦠")
            print(self.titVideo)

        } catch TITError.serverError {
            print("❌🧬🔗⬇️ Error: getting TIT Chain Link [ TITVM.getCLink() ] ⬇️🔗🧬❌")
            self.error = error
        }
    }
    
    func getCLinkVideo(linkId: String) async throws {
        guard let TIT = TIT else {
            print("❌🧬 TIT Error: TIT doesn't exist")
            throw TITError.nilTIT
        }
        let link = try await TITChainLinkManager.shared.getTitChainLink(TITid: TIT.id, titChainID: linkId)
        videoURL = try await VideoManager.shared.getVideoURL(videoID: link.videoID)!
    }
}



enum TITError: Error, LocalizedError {
    case serverError
    case nilTIT
    
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "There was an error with the server. Please try again later."
        case .nilTIT:
            return "TIT = nil"

        }
    }
}


//    func getInteraction(TITID: String) async throws { ///-> TITModel
//
//        let db = Firestore.firestore()
//        let snapshot = try await db.collection("Interactions").document(TITID).getDocument()
//
//        ///What about this approach???
//        //let ref = db.collection("Interactions").document(TITID).getDocument(as: TITModel.self)
//
//        guard let data = snapshot.data() else {
//            throw URLError(.badServerResponse)
//        }
//
//        let id                 = data["id"]                as! String
//        let name               = data["name"]              as! String
//        let description        = data["description"]       as! String
//        let thumbnailURLString = data["thumbnail_url"]     as? String
//        let creatorUID         = data["creator"]           as! String
//        let administratorsUID  = data["administrators"]    as! [String]
//        let interactionChain   = data["interaction_chain"] as! [String]
//
//        //        let dateCreated = data["date_created"] as? Date
//
//        showTIT = true
//
////        self.TIT = TITModel(id: id, name: name, description: description, thumbnailURLString: thumbnailURLString, creatorUID: creatorUID, administratorsUID: administratorsUID, interactionChain: interactionChain)
//        self.TIT = TITModel(id: id, name: name, description: description, thumbnailURLString: thumbnailURLString, creatorUID: creatorUID, administratorsUID: administratorsUID)
//
//        //        return TITModel(id: id, name: name, description: description, thumbnailURLString: thumbnailURLString, creatorUID: creatorUID, administratorsUID: administratorsUID, interactionChain: interactionChain)
//    }
