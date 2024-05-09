//
//  TIUnite.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 6/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


enum PostType: String, Codable { case video = "video", text = "text", image = "image" }

struct Post: Identifiable, Codable {
    
    @DocumentID var documentID: String?
    let id: String
    
    var title: String
    
    var type       : PostType
    var description: String?
    var imageURL   : String? /// "image
    var videoURL   : String?
    
    let creatorUID : String
    let dateCreated: Date
    
    //Is a Response List Post
    let cLinkID     : String?    ///if it's in RL provide the chain link ID. (for filtering & sorting by firebase)
    var addedToChain: Bool       ///
    
    var totalVotes: Int = 0
    var upVotes   : Int = 0
    var downVotes : Int = 0
    var upVotersUIDsArray  : [String] = []
    var downVotersUIDsArray: [String] = []
    
    var commentsArray: [String] = []

    //MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        //Type
        case type = "type", description = "description", imageURL = "image_url", videoURL = "video_url"
        //
        case creatorUID = "creator_uid"
        case dateCreated = "date_created"
        
        case cLinkID = "chain_link_id"
        case addedToChain = "added_to_chain"
        //Voting
        case totalVotes = "total_votes", upVotes = "up_votes", downVotes = "down_votes"
        case upVotersUIDsArray = "up_voters_uid", downVotersUIDsArray = "down_voters_uid"
        //Comments
        case commentsArray = "comments"
    }
    
    
    //MARK: Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id    = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        //Type
        self.type         = try container.decode(PostType.self, forKey: .type)
        self.description  = try container.decodeIfPresent(String.self, forKey: .description)
        self.imageURL     = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.videoURL     = try container.decodeIfPresent(String.self, forKey: .videoURL)
        //
        self.creatorUID  = try container.decode(String.self, forKey: .creatorUID)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        
        self.cLinkID      = try container.decodeIfPresent(String.self, forKey: .cLinkID)
        self.addedToChain = try container.decode(Bool.self, forKey: .addedToChain)
        //Votes
        self.totalVotes = try container.decode(Int.self, forKey: .totalVotes)
        self.upVotes    = try container.decode(Int.self, forKey: .upVotes)
        self.downVotes  = try container.decode(Int.self, forKey: .downVotes)
        self.upVotersUIDsArray   = try container.decode([String].self, forKey: .upVotersUIDsArray)
        self.downVotersUIDsArray = try container.decode([String].self, forKey: .downVotersUIDsArray)
        //Commets
        self.commentsArray = try container.decode([String].self, forKey: .commentsArray)
    }
    
    //MARK: - inits
    init(id: String, title: String, type: PostType, description: String?, imageURL: String?, videoURL: String?, creatorUID: String, dateCreated: Date, cLinkID: String, addedToChain: Bool,
         totalVotes: Int, upVotes: Int, downVotes: Int, upVotersUIDsArray: [String], downVotersUIDsArray: [String], commentsArray: [String]) {
        self.id = id
        self.title = title
        self.type = type
        self.description = description
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.creatorUID = creatorUID
        self.dateCreated = dateCreated
        self.cLinkID = cLinkID
        self.addedToChain = addedToChain
        self.totalVotes = totalVotes
        self.upVotes = upVotes
        self.downVotes = downVotes
        self.upVotersUIDsArray = upVotersUIDsArray
        self.downVotersUIDsArray = downVotersUIDsArray
        self.commentsArray = commentsArray
    }
}


//MARK: - Post Manager
final class PostManager {
    
    static let shared = PostManager()
    private init() { }
    
    // ,Post Document Location
    private let TICollection: CollectionReference = Firestore.firestore().collection("THEAALii's_interactions")
    private func TIDocument(tiID: String, postID: String) -> DocumentReference {
        TICollection.document(tiID).collection("posts").document(postID) }
    
    // - 1. Create
    func createTI(tiID: String, post: Post) async throws {
        try TIDocument(tiID: tiID, postID: post.id).setData(from: post, merge: false)
    }
}
