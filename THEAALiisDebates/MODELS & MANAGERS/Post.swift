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
    var text: String?
    var imageURL   : String? /// "image
    var videoURL   : String?
    
    let creatorUID : String
    let dateCreated: Date
    
    //Is a Response List Post
//    let cLinkID     : String?    ///if it's in RL provide the chain link ID. (for filtering & sorting by firebase)
    var addedToChain: Bool?
    
    
    //Votes
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
        case type = "type", text = "text", imageURL = "image_url", videoURL = "video_url"
        //
        case creatorUID = "creator_uid"
        case dateCreated = "date_created"
        
//        case cLinkID = "chain_link_id"
        case addedToChain = "added_to_chain"
        //Voting
        case totalVotes = "total_votes", upVotes = "up_votes", downVotes = "down_votes"
        case upVotersUIDsArray = "up_voters_uid", downVotersUIDsArray = "down_voters_uid"
        //Comments
        case commentsArray = "comments"
    }
    
    
    //MARK: Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        
        try container.encode(self.type, forKey: .type)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.imageURL, forKey: .imageURL)
        try container.encode(self.videoURL, forKey: .videoURL)

        try container.encode(self.creatorUID, forKey: .creatorUID)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        
        try container.encodeIfPresent(self.addedToChain, forKey: .addedToChain)
        
        try container.encode(self.totalVotes, forKey: .totalVotes)
        try container.encode(self.upVotes, forKey: .upVotes)
        try container.encode(self.downVotes, forKey: .downVotes)
        try container.encode(self.upVotersUIDsArray, forKey: .upVotersUIDsArray)
        try container.encode(self.downVotersUIDsArray, forKey: .downVotersUIDsArray)

        try container.encode(self.commentsArray, forKey: .commentsArray)
    }
    
    //MARK: Decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id    = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        //Type
        self.type         = try container.decode(PostType.self, forKey: .type)
        self.text  = try container.decodeIfPresent(String.self, forKey: .text)
        self.imageURL     = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.videoURL     = try container.decodeIfPresent(String.self, forKey: .videoURL)
        //
        self.creatorUID  = try container.decode(String.self, forKey: .creatorUID)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        
//        self.cLinkID      = try container.decodeIfPresent(String.self, forKey: .cLinkID)
        self.addedToChain = try container.decodeIfPresent(Bool.self, forKey: .addedToChain)
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
    init(id: String, title: String, type: PostType, text: String?, imageURL: String?, videoURL: String?, creatorUID: String, dateCreated: Date,
         addedToChain: Bool?) {
        self.id = id
        self.title = title
        self.type = type
        self.text = text
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.creatorUID = creatorUID
        self.dateCreated = dateCreated
//        self.cLinkID = cLinkID
        self.addedToChain = addedToChain
        self.totalVotes = 0
        self.upVotes = 0
        self.downVotes = 0
        self.upVotersUIDsArray = []
        self.downVotersUIDsArray = []
        self.commentsArray = []
    }
    
    /// -- Read --
    init(id: String, title: String, type: PostType, text: String?, imageURL: String?, videoURL: String?, creatorUID: String, dateCreated: Date,
//         cLinkID: String,
         addedToChain: Bool?,
         totalVotes: Int, upVotes: Int, downVotes: Int, upVotersUIDsArray: [String], downVotersUIDsArray: [String], commentsArray: [String]) {
        self.id = id
        self.title = title
        self.type = type
        self.text = text
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.creatorUID = creatorUID
        self.dateCreated = dateCreated
//        self.cLinkID = cLinkID
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
    private let TICollection: CollectionReference = Firestore.firestore().collection("THEAALii_Interactions")
    private func PostDocument(tiID: String, postID: String) -> DocumentReference {
        TICollection.document(tiID).collection("Posts").document(postID)
    }
    ///-----
//    private func TITVideoDocument(TITid: String, TITVideoID: String) -> DocumentReference {
//        TITCollection.document(TITid).collection("TITVideos").document(TITVideoID)
//    }
//    func createTitVideo(titID: String, titVideo: TIVideoModel) async throws {
//        try await TITVideoDocument(TITid: titID, TITVideoID: titVideo.id).setData(titVideo.dictionary)
//    }
    ///-----
    
    // - 1. Create
    func createPost(tiID: String, post: Post) async throws {
        try PostDocument(tiID: tiID, postID: post.id).setData(from: post, merge: false)
    }
    func createPost(tiID: String, post: Post, completion: @escaping (Error?)->Void) {
        do {
            try PostDocument(tiID: tiID, postID: post.id).setData(from: post) { error in
                
                
                if let error = error {
                    // Handle the error within the closure
                    print("🆘🔼🦞 Error Creating Post: \(error.localizedDescription) 🦞🔼🆘")
                    completion(error)
                } else {
                    print("✅🔼🌴 Created Post 🌴🔼✅")
                    completion(nil)
                }
            }
        } catch {
            // Handle the initial error
            print("🆘🔼🦞 Error Creating Chain Link: \(error.localizedDescription) 🦞🔼🆘")
            completion(error)
        }
    }
    
    // - 2. Read
    func fetchPost(tiID: String, postID: String) async throws -> Post? {
        try await PostDocument(tiID: tiID, postID: postID).getDocument(as: Post.self)
    }
    func getPost(tiID: String, postID: String, completion: @escaping (Result<Post, Error>) -> Void) {
        
        PostDocument(tiID: tiID, postID: postID).getDocument(as: Post.self) { result in
            switch result {
                
            case .success(let post):
                print("✅⬇️🎃⚛️ Success getting Post🎃 ⚛️🎃⬇️✅")
                completion(.success(post))
            case .failure(let error):
                print("❌⬇️🎃⚛️ Error getting Post🎃: \(error.localizedDescription) ⚛️🎃⬇️❌")
                completion(.failure(error))
            }
        }
    }
    
    // - 3. Update
    
    //Voting (up or down)
    //add to Chain
    
    
    // - 4. Delete
//    func deletePost(tiID: String, postID: String) async throws {
//        try await PostDocument(tiID: tiID, postID: postID).delete()
//    }

    func deletePost(tiID: String, postID: String, completion: @escaping (Result <Void, Error>) -> Void ) {
        
        PostDocument(tiID: tiID, postID: postID).delete { [weak self] error in //(any Error)? in
            guard let _ = self else { return }
            if let error = error {
                completion(.failure(error))
            }
            completion( .success(()) )
        }
    }
}
