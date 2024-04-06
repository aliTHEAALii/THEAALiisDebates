//
//  AALiiInteractionModel.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/29/23.
//

//import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK: - TIT Model
struct TIModel: Identifiable, Codable, Hashable {
    
    @DocumentID var documentID: String?
    var id: String                                  //Pay to set your own ID
    
    var name: String
    var description: String
    var thumbnailURLString: String?
    
    var creatorUID: String?
    var administratorsUID: [String] = []
    
    var interactionChain: [String] //FIXME: UID or ID
    
    var observersUIDs: [String]? = []
    
    //for firebase
    var dictionary: [String: Any?] {
        return [
            "id"               : id,
            "name"             : name,
            "description"      : description,
            "thumbnail_url"    : thumbnailURLString,
            "creator"          : creatorUID,
            "administrators"   : administratorsUID,
            "interaction_chain": interactionChain,
            "observers_uids"   : observersUIDs
        ]
    }
    
    //MARK: - Initilizer
    init(id: String,
         name: String,
         description: String,
         thumbnailURLString: String?,
         creatorUID: String,
         administratorsUID: [String],
         interactionChain: [String] = []
    ) {
        self.documentID = id
        self.id = id
        self.name = name
        self.description = description
        self.thumbnailURLString = thumbnailURLString
        self.creatorUID = creatorUID
        self.administratorsUID = administratorsUID
        self.interactionChain = interactionChain
        self.observersUIDs = [creatorUID]

    }
    
    //MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        
        case id                 = "id"
        case name               = "name"
        case description        = "description"
        case thumbnailURLString = "thumbnail_url"
        case creatorUID         = "creator"
        case administratorsUID  = "administrators"
        case interactionChain   = "interaction_chain"
        case observersUIDs       = "observers_uids"
    }
    
    //MARK: Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnailURLString = try container.decodeIfPresent(String.self, forKey: .thumbnailURLString)
        self.creatorUID = try container.decode(String.self, forKey: .creatorUID)
        self.administratorsUID = try container.decode([String].self, forKey: .administratorsUID)
        self.interactionChain = try container.decode([String].self, forKey: .interactionChain)
        self.observersUIDs = try container.decodeIfPresent([String].self, forKey: .observersUIDs)
    }

    //MARK: Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.creatorUID, forKey: .creatorUID)
        try container.encode(self.administratorsUID, forKey: .administratorsUID)
        try container.encode(self.interactionChain, forKey: .interactionChain)
        try container.encodeIfPresent(self.thumbnailURLString, forKey: .thumbnailURLString)
        try container.encodeIfPresent(self.observersUIDs, forKey: .observersUIDs)
    }
}

//MARK: - TIT Manager
final class TITManager {
    
    static let shared = TITManager()
    private init() { }
    
    private let TITCollection: CollectionReference = Firestore.firestore().collection("Interactions")
    private func TITDocument(TITid: String) -> DocumentReference {
        TITCollection.document(TITid)
    }
    
    ///1. Create
    func createTIT(TITModel: TIModel) async throws {
        try TITDocument(TITid: TITModel.id).setData(from: TITModel, merge: false) //should have [ await ]
    }
    
    ///2. Read
    func getTIT(TITid: String) async throws -> TIModel {
        do {
            return try await TITDocument(TITid: TITid).getDocument(as: TIModel.self)
        } catch {
            print("❌ get tit error" + error.localizedDescription)
            throw error
        }
    }
    
    ///3. Update
    func addToChain(titId: String, chainId: String) async throws {
        let chainLink: [String : Any] = [
            TIModel.CodingKeys.interactionChain.rawValue : FieldValue.arrayUnion([chainId])
        ]
        
        try await TITDocument(TITid: titId).updateData(chainLink)
    }
    
    func addOrRemoveAdmin(tiId: String, userId: String, addOrRemove: AddOrRemove) async throws {
        if addOrRemove == .add {
            let adminsData: [String: Any]  = [
                TIModel.CodingKeys.administratorsUID.rawValue : FieldValue.arrayUnion([userId])
            ]
            try await TITDocument(TITid: tiId).updateData(adminsData)
        } else if addOrRemove == .remove {
            let adminsData: [String: Any]  = [
                TIModel.CodingKeys.administratorsUID.rawValue : FieldValue.arrayRemove([userId])
            ]
            try await TITDocument(TITid: tiId).updateData(adminsData)
        }
    }
    //4. Delete
}


////MARK: - TIT Video Model
//struct TITVideoModel: Identifiable, Codable, Hashable {
//
//    @DocumentID var documentID: String?
//    var id: String
//
//    let videoURL: String
//    var thumbnail: String?
//
//    var creatorUID: String
//
//    var name: String
//    var description: String
//
//    //Votes
//    var upVotes  : Int = 0
//    var downVotes: Int = 0
//    var upVotersUIDArray  : [String] = []
//    var downVotersUIDArray: [String] = []
//
//    //comments
//    var commentsArray: [String] = []
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//
////        case videoURL = "video_url"
////        case thumbnail = "thumbnail"
////
////        case creatorUID = "creator_uid"
////
////        case name = "name"
////        case description = "description"
////
////        case upVotes  = "up_votes"
////        case downVotes  = "down_votes"
////        case upVotersUIDArray  = "up_voters_uid_array"
////        case downVotersUIDArray  = "down_voters_uid_array"
////
////        case commentsArray = "comments"
//    }
//
//    //MARK: Decoder
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
////        self.videoURL = try container.decode(String.self, forKey: .videoURL)
////        self.creatorUID = try container.decode(String.self, forKey: .creatorUID)
////        self.name = try container.decode(String.self, forKey: .name)
////        self.description = try container.decode(String.self, forKey: .description)
////        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
////        self.creatorUID = try container.decode(String.self, forKey: .creatorUID)
////        self.upVotes = try container.decode(Int.self, forKey: .upVotes)
////        self.downVotes = try container.decode(Int.self, forKey: .downVotes)
////        self.upVotersUIDArray = try container.decode([String].self, forKey: .upVotersUIDArray)
////        self.downVotersUIDArray = try container.decode([String].self, forKey: .downVotersUIDArray)
////        self.commentsArray = try container.decode([String].self, forKey: .commentsArray)
//    }
//
//    //MARK: Encoder
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
////        try container.encode(self.videoURL, forKey: .videoURL)
////        try container.encodeIfPresent(self.thumbnail, forKey: .thumbnail)
////        try container.encode(self.creatorUID, forKey: .creatorUID)
////        try container.encode(self.name, forKey: .name)
////        try container.encode(self.description, forKey: .description)
////        try container.encode(self.upVotes, forKey: .upVotes)
////        try container.encode(self.downVotes, forKey: .downVotes)
////        try container.encode(self.upVotersUIDArray, forKey: .upVotersUIDArray)
////        try container.encode(self.downVotersUIDArray, forKey: .downVotersUIDArray)
////        try container.encode(self.commentsArray, forKey: .commentsArray)
//    }
//}
//
////MARK: - TIT Video Manager
//final class TITVideoManager {
//
//    static let shared = TITVideoManager()
//    private init() { }
//
//    private let TITCollection: CollectionReference = Firestore.firestore().collection("Interactions")
//    //Another layer to go to
//    private func TITVideoDocument(TITid: String, TITVideoID: String) -> DocumentReference {
//        TITCollection.document(TITid)
//
////        TITCollection.document(TITid).collection("TITVideos").document(TITVideoID)
//    }
//
//    func createTITVideo(TITid: String, TITVideoID: String) async throws {
//
//        try TITVideoDocument(TITid: TITid, TITVideoID: TITVideoID).setData(from: TITModel, merge: false)
//////        try TITDocument(TITid: TITModel.id).setData(from: TITModel) //should have [ await ]
//    }
//
//}

//MARK: - Comment Model
struct CommentModel: Identifiable {
    
    let id: String
    
    let creatorUID: String
    
    let body: String
    
    let upVotes  : Int
    let downVotes: Int
    let upVotersUIDArray  : [String]
    let downVotersUIDArray: [String]
    
}


//MARK: - Decoder Code Sample
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try values.decode(String.self, forKey: .id)
//
//        self.name = try values.decode(String.self, forKey: .name)
//        self.description = try values.decode(String.self, forKey: .description)
//
//        self.creatorUID = try values.decode(String.self, forKey: .creatorUID)
//        self.administratorsUID = try values.decode([String].self, forKey: .administratorsUID)
//
//        self.interactionChain = try values.decode([String].self, forKey: .interactionChain)
//
//
//
//
//        if values.contains(.thumbnailURLString) {
//            //                let thumbnail = try values.nestedContainer(keyedBy: String.self, forKey: .thumbnailURLString)
//            self.thumbnailURLString = try values.decodeIfPresent(String.self, forKey: .thumbnailURLString)
//        } else {
//            self.thumbnailURLString = nil
//        }
//    }
