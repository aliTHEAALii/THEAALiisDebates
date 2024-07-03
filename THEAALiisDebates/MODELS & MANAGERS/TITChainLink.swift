//
//  TITChainLinkManager.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/12/23.
//

//import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK: - TIT Chain Link Model
struct TITChainLinkModel: Identifiable, Codable {
    
    @DocumentID var documentID: String?
    var id: String
    var videoID: String
    var responseList: [String] = []
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "video_id": videoID,
            "response_list": responseList
        ]
    }
    
    init(id: String, postID: String, verticalList: [String]) {
        self.documentID = id
        self.id = id
        self.videoID = postID
        self.responseList = verticalList
    }
}

//MARK: - TIT Chain Manager
final class TITChainLinkManager {
    
    static let shared = TITChainLinkManager()
    private init() { }
    
    private let TITCollection: CollectionReference = Firestore.firestore().collection("Interactions")
    private func TITChainDocument(TITid: String, TITChainID: String) -> DocumentReference {
        TITCollection.document(TITid).collection("TIT_Chain").document(TITChainID)
    }
    
    //MARK: - 1. Create
    func createTITChainLink(TITid: String, TITChainLink: TITChainLinkModel) async throws {
        try await TITChainDocument(TITid: TITid, TITChainID: TITChainLink.id).setData(TITChainLink.dictionary)
    }
    
    
    //MARK: - 2. Read
    func getTitChainLink(TITid: String, titChainID: String) async throws -> TITChainLinkModel {
        let snapShot = try await TITChainDocument(TITid: TITid, TITChainID: titChainID).getDocument()

        guard let data = snapShot.data() else {
            print("❌🤬🔗 Error: Couldn't getTITChainLink()🔗 data from snapshot 🔗🤬❌")
            throw URLError(.badServerResponse)
        }
        //NON-Optional
        guard
            let id = data["id"] as? String,
            let videoID = data["video_id"] as? String
        else {
            print("❌🤬🔗 Error: Couldn't read getTITChainLink()🔗 data components 🔗🤬❌")
            throw URLError(.badServerResponse)
        }
        //Optional
        let responseList = data["response_list"] as? [String] ?? []

        return TITChainLinkModel(id: id, postID: videoID, verticalList: responseList)
    }
    
    //3. Update
    
    //4. Delete
}

//MARK: - Codable Model
/**
 TIT chain Link using Codable
 - Returns: An attempt
 */
struct TITChainLModel: Identifiable, Codable {
    
    @DocumentID var documentId: String?
    let id: String
    
    let videoId: String?
    let videoTitle: String?
    var videoThumbnail: String?
    
    var responseList: [String]? = []

    init(id: String, videoId: String, videoTitle: String, videoThumbnail: String?, responseList: [String]) {
        self.documentId = id
        self.id = id
        self.videoId = videoId
        self.videoTitle = videoTitle
        self.videoThumbnail = videoThumbnail
        self.responseList = responseList
    }
    
    //MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id           = "id"
        case videoId      = "video_id"
        case videoTitle      = "video_title"
        case videoThumbnail      = "video_thumbnail"
        case responseList = "response_list"
        
    }
    
    //Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.videoId = try container.decodeIfPresent(String.self, forKey: .videoId)
        self.videoTitle = try container.decodeIfPresent(String.self, forKey: .videoTitle)
        self.videoThumbnail = try container.decodeIfPresent(String.self, forKey: .videoThumbnail)
        self.responseList = try container.decodeIfPresent([String].self, forKey: .responseList)
    }
    
    //Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.videoId, forKey: .videoId)
        try container.encodeIfPresent(self.videoTitle, forKey: .videoTitle)
        try container.encodeIfPresent(self.videoThumbnail, forKey: .videoThumbnail)
        try container.encodeIfPresent(self.responseList, forKey: .responseList)
    }
}

/** TIT Chain Manager **/
final class TITChainLManager {
    
    static let shared = TITChainLManager()
    private init() { }
    
    //location in Firebase
    private let TITCollection: CollectionReference = Firestore.firestore().collection("Interactions")
    private func TITChainDocument(TITid: String, TITChainID: String) -> DocumentReference {
        TITCollection.document(TITid).collection("TIT_Chain").document(TITChainID)
    }
    
    //1. Create
    func createCLink(titId: String, titCL: TITChainLModel) async throws {
        try TITChainDocument(TITid: titId, TITChainID: titCL.id).setData(from: titCL)
    }
    
    //2. Read
    func readCLink(titId: String, titCLinkId: String) async throws -> TITChainLModel {
        try await TITChainDocument(TITid: titId, TITChainID: titCLinkId).getDocument(as: TITChainLModel.self)
    }
    
    
    //3. - Update
    func addtotiChain(tiId: String, tiChainId: String, tiVideoId: String) async throws {
        let _: [String: Any] = [  //tiChainIdData
            TIModel.CodingKeys.interactionChain.rawValue : FieldValue.arrayUnion([tiChainId])
        ]
        
//        try await TITManager.shared.addToChain(titId: tiId, chainId: tiChainId).updateData(tiChainIdData)
        try await TITManager.shared.addToChain(titId: tiId, chainId: tiChainId)

    }
    
    func addToResponseList(tiId: String, tiChainId: String, tiVideoId: String) async throws {
        let chainData: [String: Any] = [
            TITChainLModel.CodingKeys.responseList.rawValue : FieldValue.arrayUnion([tiVideoId] as! [Any] )
        ]
        try await TITChainDocument(TITid: tiId, TITChainID: tiChainId).updateData(chainData)
    }

    
    //4. Delete
    func deleteFromResponseList(titId: String, titChainLId: String, titVideoId: String) async throws {
        let videoIdData: [String : Any] = [
            TITChainLModel.CodingKeys.responseList.rawValue : FieldValue.arrayRemove([titVideoId])
        ]
        try await TITChainDocument(TITid: titId, TITChainID: titChainLId).updateData(videoIdData)
        print("tiVideo Removed from RS 🧐🧪👩‍🔬")
    }
}
