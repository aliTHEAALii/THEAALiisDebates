//
//  DebateModel.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 3/28/23.
//

import Foundation
import FirebaseFirestoreSwift


class DebateModel: Identifiable, Decodable {
    
    @DocumentID var documentID: String?
    var id: String = UUID().uuidString
    
    //Debate Info
    var debateName: String = ""
    var debateDescription: String = ""
    var debateThumbnailURLString: String? = nil
    
    //Creator info
    var debateCreatorUID: String = ""
//    var Administrators: [String] = []
    
    //Chain Info
    var debateChain: [String] = []
    
    init(id: String, debateName: String, debateDescription: String, debateThumbnailURLString: String? = nil, debateCreatorUID: String, debateChain: [String]) {
        self.id = id
        self.debateName = debateName
        self.debateDescription = debateDescription
        self.debateThumbnailURLString = debateThumbnailURLString
        self.debateCreatorUID = debateCreatorUID
        self.debateChain = debateChain
    }
    
    enum CodingKeys: CodingKey {
        case id
        case debateName
        case debateDescription
        case debateThumbnailURLString //move above debateChain
        
        case debateCreatorUID

        case debateChain
    }
    
    
    var dictionary: [String: Any] {
        return ["id": id,
                
                "debate_name": debateName,
                "debate_description": debateDescription,
                "debate_thumbnail_URL_string": debateThumbnailURLString ?? "",
                
                "debate_creator_UID": debateCreatorUID,
                
                "debate_chain": debateChain
        ]
    }
    
    //    @DocumentID var id: String?
    //    var userUID: String = "" // same as id
    //    var email: String = ""
    //
    //    var name: String = ""
    //    var bio: String = ""
    //    var profileImageURL: URL? = nil
    //    var profileImageURLString: String? = nil
    //
    //
    //    enum CodingKeys: CodingKey {
    //        case id
    //        case userUID
    //        case email
    //
    //        case name
    //        case bio
    //        case profileImageURLString
    //    }
    //
    //    var dictionary: [String: Any] {
    //        return ["userUID": userUID, "email": email, "name": name, "bio": bio, "profileImageURLString": profileImageURLString]
    //    }
}
