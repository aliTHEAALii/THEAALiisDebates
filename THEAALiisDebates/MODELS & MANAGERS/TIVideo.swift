//
//  TITVideoModel.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/11/23.
//

//import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

//MARK: - TI Video Model
struct TIVideoModel: Identifiable, Codable, Hashable {
    
    @DocumentID var documentID: String?
    var id: String
    
    let videoURL: String
    var thumbnail: String?
    
    var creatorID: String? ///the creator might delete their account
    var addedToChain: Bool = false
    
    var name: String
    var description: String
    
    var chainLId: String?
    //Votes
    var totalVotes: Int = 0
    var upVotes  : Int = 0
    var downVotes: Int = 0
    var upVotersIDArray  : [String] = []
    var downVotersIDArray: [String] = []
    //comments
    var commentsArray: [String] = []
    
    //MARK: Dictionary
    ///for Firebase creating a TITVideo
    var dictionary: [String: Any] {
        //NON-Optional
        var dict: [String: Any] = [
            "id": id,
            "video_url": videoURL,
            
            "added_to_chain": addedToChain,
            
            "name": name,
            "description": description,
            
            "total_votes": totalVotes,
            "up_votes": upVotes,
            "down_votes": downVotes,
            "up_voters_id_array": upVotersIDArray,
            "down_voters_id_array": downVotersIDArray,
            
            "comments": commentsArray
        ]
        //optionals
        if thumbnail != nil { dict["thumbnail"]     = thumbnail }
        if creatorID != nil { dict["creator_id"]    = creatorID }
        if chainLId  != nil { dict["chain_link_id"] = chainLId  }
        
        return dict
    }
    
    // Create init
    init(id: String, videoURL: String, thumbnail: String?, creatorID: String, name: String, description: String, chainLId: String?) {
        self.documentID = id
        self.id = id
        
        self.videoURL = videoURL
        self.thumbnail = thumbnail
        self.creatorID = creatorID
        
        self.name = name
        self.description = description
        
        self.chainLId = chainLId
    }
    
    //Read init
    init(id: String, videoURL: String, thumbnail: String?, creatorID: String?, addedToChain: Bool, name: String, description: String,
         chainLId: String?, totalVotes: Int, upVotes: Int, downVotes: Int, upVotersIDArray: [String], downVotersIDArray: [String], commentsArray: [String]) {
        self.documentID = id
        self.id = id
        
        self.videoURL = videoURL
        self.thumbnail = thumbnail
        self.creatorID = creatorID
        self.addedToChain = addedToChain
        
        self.name = name
        self.description = description
        
        self.chainLId = chainLId
        
        self.totalVotes = totalVotes
        self.upVotes = upVotes
        self.downVotes = downVotes
        self.upVotersIDArray = upVotersIDArray
        self.downVotersIDArray = downVotersIDArray
        
        self.commentsArray = commentsArray
    }
    
//MARK: - Codable Code
    enum CodingKeys: String, CodingKey {

        case id = "id"

        case videoURL = "video_url"
        case thumbnail = "thumbnail"

        case creatorID = "creator_uid"
        case addedToChain = "added_to_chain"

        case name = "name"
        case description = "description"

        case chainLId = "chain_link_id"
        
        case upVotes  = "up_votes"
        case downVotes  = "down_votes"
        case upVotersIDArray  = "up_voters_uid_array"
        case downVotersIDArray  = "down_voters_uid_array"

        case commentsArray = "comments"
    }

    //MARK: Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.videoURL = try container.decode(String.self, forKey: .videoURL)

        self.creatorID = try container.decode(String.self, forKey: .creatorID)
        self.addedToChain = try container.decode(Bool.self, forKey: .addedToChain)

        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        
        self.chainLId = try container.decodeIfPresent(String.self, forKey: .chainLId)

        self.upVotes = try container.decode(Int.self, forKey: .upVotes)
        self.downVotes = try container.decode(Int.self, forKey: .downVotes)
        self.upVotersIDArray = try container.decode([String].self, forKey: .upVotersIDArray)
        self.downVotersIDArray = try container.decode([String].self, forKey: .downVotersIDArray)

        self.commentsArray = try container.decode([String].self, forKey: .commentsArray)
    }

    //MARK: Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.videoURL, forKey: .videoURL)
        try container.encodeIfPresent(self.thumbnail, forKey: .thumbnail)
        try container.encode(self.creatorID, forKey: .creatorID)
        try container.encode(self.addedToChain, forKey: .addedToChain)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encodeIfPresent(self.chainLId, forKey: .chainLId)
        try container.encode(self.upVotes, forKey: .upVotes)
        try container.encode(self.downVotes, forKey: .downVotes)
        try container.encode(self.upVotersIDArray, forKey: .upVotersIDArray)
        try container.encode(self.downVotersIDArray, forKey: .downVotersIDArray)
        try container.encode(self.commentsArray, forKey: .commentsArray)
    }
}

//MARK: - TIT Video Manager
final class TITVideoManager {
    
    static let shared = TITVideoManager()
    private init() { }
    
    //Video Location in FB
    private let TITCollection: CollectionReference = Firestore.firestore().collection("Interactions")
    private func TITVideoDocument(TITid: String, TITVideoID: String) -> DocumentReference {
        TITCollection.document(TITid).collection("TITVideos").document(TITVideoID)
    }
    
    //MARK: - 1. Create
    func createTitVideo(titID: String, titVideo: TIVideoModel) async throws {
        try await TITVideoDocument(TITid: titID, TITVideoID: titVideo.id).setData(titVideo.dictionary as [String : Any])
    }
    
    //MARK: - 2. Read
    func getTITVideo(TITid: String, TITVideoID: String) async throws -> TIVideoModel {
        let document = try await TITVideoDocument(TITid: TITid, TITVideoID: TITVideoID).getDocument()
        
        guard let data = document.data() else {
            print("❌🤬 Error: Couldn't getTITVideo() data from snapshot 🤬❌")
            throw URLError(.badServerResponse)
        }
        
        //NON-Optionals
        guard let videoID = data["id"] as? String,
              let videoURL = data["video_url"] as? String,
              let name = data["name"] as? String
                
        else {
            print("❌🤬 Error: Couldn't gatTITVideo() data components 🤬❌")
            throw URLError(.badServerResponse)
        }
        
        //Optionals
        let thumbnail = data["thumbnail"] as? String
        let creatorID = data["creator_id"] as? String
        let addedToChain = data["added_to_chain"] as? Bool ?? false
        let description = data["description"] as? String ?? ""
        let chainLId = data["chain_link_id"] as? String ?? nil
        let totalVotes = data["total_votes"] as? Int ?? 0
        let upVotes = data["up_votes"] as? Int ?? 0
        let downVotes = data["down_votes"] as? Int ?? 0
        let upVotersIDArray = data["up_voters_id_array"] as? [String] ?? []
        let downVotersIDArray = data["down_voters_id_array"] as? [String] ?? []
        let commentsArray = data["comments"] as? [String] ?? []
        
        return TIVideoModel(id: videoID, videoURL: videoURL, thumbnail: thumbnail, creatorID: creatorID, addedToChain: addedToChain,
                            name: name, description: description, chainLId: chainLId, totalVotes: totalVotes,
                             upVotes: upVotes, downVotes: downVotes, upVotersIDArray: upVotersIDArray, downVotersIDArray: downVotersIDArray,
                             commentsArray: commentsArray)
    }
    
    //MARK: - get RL Videos
        func fetchResponseListVideos(tiId: String, tiChainLId: String) async throws -> [TIVideoModel] {
            print("🫀 entered RL")
            let querySnapshot = try await TITCollection.document(tiId).collection("TITVideos")
                .whereField("chain_link_id", isEqualTo: tiChainLId).order(by: "total_votes", descending: true).getDocuments()
            print("🫀 querySnapshot RL 🫀")

            var responseList: [TIVideoModel] = []
            
            for document in querySnapshot.documents {
                let data = document.data()
                print("🫀 document RL 🫀")

                //NON-Optionals
                guard let videoID = data["id"] as? String,
                      let videoURL = data["video_url"] as? String,
                      let name = data["name"] as? String
                        
                else {
                    print("❌🤬 Error: Couldn't gatTITVideo() data components 🤬❌")
                    throw URLError(.badServerResponse)
                }
                
                //Optionals
                let thumbnail = data["thumbnail"] as? String
                let creatorID = data["creator_id"] as? String
                let addedToChain = data["added_to_chain"] as? Bool ?? false
                let description = data["description"] as? String ?? ""
                let chainLId = data["chain_link_id"] as? String ?? nil
                let totalVotes = data["total_votes"] as? Int ?? 0
                let upVotes = data["up_votes"] as? Int ?? 0
                let downVotes = data["down_votes"] as? Int ?? 0
                let upVotersIDArray = data["up_voters_id_array"] as? [String] ?? []
                let downVotersIDArray = data["down_voters_id_array"] as? [String] ?? []
                let commentsArray = data["comments"] as? [String] ?? []
                
                responseList.append(TIVideoModel(id: videoID, videoURL: videoURL, thumbnail: thumbnail, creatorID: creatorID, addedToChain: addedToChain,
                                    name: name, description: description, chainLId: chainLId, totalVotes: totalVotes,
                                     upVotes: upVotes, downVotes: downVotes, upVotersIDArray: upVotersIDArray, downVotersIDArray: downVotersIDArray,
                                                 commentsArray: commentsArray) )
            }
            
            print("🫀  RL \(responseList) 🫀")
            return responseList
        }
    
    //MARK: - 3. Update -
    func addedToChain(tiId: String, tiVideoId: String) async throws {
        try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["added_to_chain" : true])
    }
    
    //MARK: Voting functions
    
    //upvote
    func updateUpVotersArray(tiId: String, tiVideoId: String, userId: String, addOrRemove: AddOrRemove) async throws {
        var videoData: [String: Any] = [ "up_voters_id_array" : (Any).self ]
        
        if addOrRemove == .add {
            videoData = [ "up_voters_id_array": FieldValue.arrayUnion([userId] as! [Any] )  ]
        } else {
            videoData = [ "up_voters_id_array": FieldValue.arrayRemove([userId] as! [Any] ) ]
        }
        
        try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(videoData)
    }
    
    //down Vote
    func updateDownVotersArray(tiId: String, tiVideoId: String, userId: String, addOrRemove: AddOrRemove) async throws {
        var videoData: [String: Any] = ["down_voters_id_array": (Any).self]
        
        if addOrRemove == .add {
            videoData = [ "down_voters_id_array": FieldValue.arrayUnion([userId] as! [Any] )  ]
        } else {
            videoData = [ "down_voters_id_array": FieldValue.arrayRemove([userId] as! [Any] ) ]
        }
        
        try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(videoData)
    }
    
    //Increment & Decrement Votes

    func changeUpVotes(tiId: String, tiVideoId: String, increaseOrDecrease: IncreaseOrDecrease) async throws {
        if increaseOrDecrease == .increase {
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["up_votes" : FieldValue.increment(Int64(1))])
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["total_votes" : FieldValue.increment(Int64(1))])
        } else {
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["up_votes" : FieldValue.increment(Int64(-1))])
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["total_votes" : FieldValue.increment(Int64(-1))])
        }
    }
    func changeDownVotes(tiId: String, tiVideoId: String, increaseOrDecrease: IncreaseOrDecrease) async throws {
        if increaseOrDecrease == .increase {
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["down_votes" : FieldValue.increment(Int64(1))])
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["total_votes" : FieldValue.increment(Int64(-1))])
        } else {
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["down_votes" : FieldValue.increment(Int64(-1))])
            try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).updateData(["total_votes" : FieldValue.increment(Int64(1))])

        }
    }
    
    
    
    //MARK: - 4. Delete -
    func deleteTIVideo(tiId: String, tiVideoId: String) async throws {
        try await TITVideoDocument(TITid: tiId, TITVideoID: tiVideoId).delete()
    }
}







//MARK: - Codable Code
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//
//        case videoURL = "video_url"
//        case thumbnail = "thumbnail"
//
//        case creatorUID = "creator_uid"
//        case addedToChain = "added_to_chain"
//
//        case name = "name"
//        case description = "description"
//
//        case upVotes  = "up_votes"
//        case downVotes  = "down_votes"
//        case upVotersUIDArray  = "up_voters_uid_array"
//        case downVotersUIDArray  = "down_voters_uid_array"
//
//        case commentsArray = "comments"
//    }
//
//    //MARK: Decoder
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.videoURL = try container.decode(String.self, forKey: .videoURL)
//
//        self.creatorUID = try container.decode(String.self, forKey: .creatorUID)
//        self.addedToChain = try container.decode(Bool.self, forKey: .addedToChain)
//
//        self.name = try container.decode(String.self, forKey: .name)
//        self.description = try container.decode(String.self, forKey: .description)
//        self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
//
//        self.upVotes = try container.decode(Int.self, forKey: .upVotes)
//        self.downVotes = try container.decode(Int.self, forKey: .downVotes)
//        self.upVotersUIDArray = try container.decode([String].self, forKey: .upVotersUIDArray)
//        self.downVotersUIDArray = try container.decode([String].self, forKey: .downVotersUIDArray)
//
//        self.commentsArray = try container.decode([String].self, forKey: .commentsArray)
//    }
//
//    //MARK: Encoder
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.videoURL, forKey: .videoURL)
//        try container.encodeIfPresent(self.thumbnail, forKey: .thumbnail)
//        try container.encode(self.creatorUID, forKey: .creatorUID)
//        try container.encode(self.addedToChain, forKey: .addedToChain)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.description, forKey: .description)
//        try container.encode(self.upVotes, forKey: .upVotes)
//        try container.encode(self.downVotes, forKey: .downVotes)
//        try container.encode(self.upVotersUIDArray, forKey: .upVotersUIDArray)
//        try container.encode(self.downVotersUIDArray, forKey: .downVotersUIDArray)
//        try container.encode(self.commentsArray, forKey: .commentsArray)
//    }



//1. codable Create
//    func createTITVideo(TITid: String, TITVideoID: String) async throws { //FIXME: -
//        ///Codable
//        //        try TITVideoDocument(TITid: TITid, TITVideoID: TITVideoID).setData(from: TITVideoModel, merge: false)
//
//        var TITVideoTestDict = TITVideoModel(id: "1srTestingTITVideoID", videoURL: "empty", thumbnail: nil, creatorID: "testing creator", name: "1st testing TITVideo", description: "My 1st TIT Video for testing . Description").dictionary
//
////        try await TITVideoDocument(TITid: TITid, TITVideoID: TITVideoID).setData(TITVideoTest.dictionary)
//        try await TITVideoDocument(TITid: TITid, TITVideoID: TITVideoID).setData(TITVideoTestDict)
//
//
//    }

//2. Codable Read
///Codable
//try await TITVideoDocument(TITid: TITid, TITVideoID: TITVideoID).getDocument(as: TITVideoModel.self)
