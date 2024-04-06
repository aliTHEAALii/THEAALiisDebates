////
////  THEAALiiInteractionModel.swift
////  TheAaliiDebates
////
////  Created by Ali Abraham on 5/30/23.
////
//
//import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum InteractionType   : String, Codable { case post = "post",  d1 = "thread", d2 = "vs" }
enum ResponseListAccess: String, Codable { case open = "open", restricted = "restricted", closed = "closed" }
enum RightOrLeft { case right, left }

struct TI: Identifiable, Codable {
    
    @DocumentID var documentID: String?
    var id: String
    
    let title: String
    var description: String
    var thumbnailURL: String?

    let introCLinkID: String? ///date - Chain
    
    let creatorUID: String
    let dateCreated: Date
    
    //chain
    var interactionType: InteractionType = .d1
    
    var rightChain: [String] = []
    var rightChainAdminsUIDs: [String] = []
    
    var leftChain: [String] = []
    var leftChainAdminsUIDs: [String] = []
    
    var responseListAccess: ResponseListAccess = .open
    var responseListAddersUIDs: [String] = []
    
    var observersUIDs: [String] = []

    
    // - create init - //
    init(ID: String, title: String, description: String, thumbnailURL: String?, introCLinkID: String, creatorUID: String,
         interactionType: InteractionType, responseListAccess: ResponseListAccess) {
        self.documentID = ID
        self.id = ID
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL; self.introCLinkID = introCLinkID
        self.creatorUID = creatorUID
        self.dateCreated = Date()
        self.interactionType = interactionType; self.responseListAccess = responseListAccess
    }
    
    // - Read init - //
    init(ID: String, title: String, description: String, thumbnailURL: String?, introCLinkID: String, creatorUID: String, dateCreated: Date,
         interactionType: InteractionType, rightChain: [String], leftChain: [String], responseListAccess: ResponseListAccess) {
        self.documentID = ID
        self.id = ID
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL; self.introCLinkID = introCLinkID
        self.creatorUID = creatorUID
        self.dateCreated = dateCreated
        self.interactionType = interactionType; self.rightChain = rightChain; self.leftChain = leftChain
        self.responseListAccess = responseListAccess
    }
    
    //MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case title              = "title"
        case description        = "description"
        case thumbnailURL       = "thumbnail_url"
        case introCLinkID       = "intro_chain_link_id"
        case creatorUID         = "creator_uid"
        case dateCreated        = "date_created"
        case interactionType    = "interaction_type"
        //
        case rightChain         = "right_chain"
        case rightChainAdminsUIDs = "right_chain_admins_uids"
        case leftChain         = "left_chain"
        case leftChainAdminsUIDs = "left_chain_admins_uids"
        
        case responseListAccess = "response_list_access"
        case responseListAddersUIDs = "response_list_adders_uids"
        
        case observersUIDs      = "observers_uids"
    }
    
    //MARK: Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        self.introCLinkID = try container.decode(String.self, forKey: .introCLinkID)
        
        self.creatorUID = try container.decode(String.self, forKey: .creatorUID)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        
        self.interactionType = try container.decode(InteractionType.self, forKey: .interactionType)
        self.rightChain = try container.decode([String].self, forKey: .rightChain)
        self.rightChainAdminsUIDs = try container.decode([String].self, forKey: .rightChainAdminsUIDs)
        self.leftChain = try container.decode([String].self, forKey: .leftChain)
        self.leftChainAdminsUIDs = try container.decode([String].self, forKey: .leftChainAdminsUIDs)
        
        self.responseListAccess = try container.decode(ResponseListAccess.self, forKey: .responseListAccess)
        self.responseListAddersUIDs = try container.decode([String].self, forKey: .responseListAddersUIDs)

        self.observersUIDs = try container.decode([String].self, forKey: .observersUIDs)
    }

    //MARK: Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.thumbnailURL, forKey: .thumbnailURL)
        try container.encode(self.introCLinkID, forKey: .introCLinkID)
        try container.encode(self.creatorUID, forKey: .creatorUID)
        try container.encode(self.dateCreated, forKey: .dateCreated)
        
        try container.encode(self.interactionType, forKey: .interactionType)
        try container.encode(self.rightChain, forKey: .rightChain)
        try container.encode(self.rightChainAdminsUIDs, forKey: .rightChainAdminsUIDs)
        try container.encode(self.leftChain, forKey: .leftChain)
        try container.encode(self.leftChainAdminsUIDs, forKey: .leftChainAdminsUIDs)

        try container.encodeIfPresent(self.responseListAccess, forKey: .responseListAccess)
        try container.encodeIfPresent(self.responseListAddersUIDs, forKey: .responseListAddersUIDs)
        
        try container.encodeIfPresent(self.observersUIDs, forKey: .observersUIDs)
    }
}




final class TIManager {
    
    static let shared = TIManager()
    private init() { }
    
    //TI Document Location
    private let TICollection: CollectionReference = Firestore.firestore().collection("THEAALii_Interactions")
    private func TIDocument(tiID: String) -> DocumentReference { TICollection.document(tiID) }
    
    // - 1. Create
    func createTI(ti: TI) async throws {
        try TIDocument(tiID: ti.id).setData(from: ti, merge: false)
    }
    
    // - 2. Read
    func fetchTI(tiID: String) async throws -> TI? {
        try await TIDocument(tiID: tiID).getDocument(as: TI.self)
    }
    
    // - 3. Update
    
    //MARK: add ti video to chain
    func addToChain(tiID: String, CLinkID: String, rightOrLeft: RightOrLeft) async throws {
        var chainData = [String: Any]()
        
        if rightOrLeft == .right {
            chainData = [ TI.CodingKeys.rightChain.rawValue : FieldValue.arrayUnion([CLinkID]) ]
            
        } else if rightOrLeft == .left {
            chainData = [ TI.CodingKeys.rightChain.rawValue : FieldValue.arrayRemove([CLinkID]) ]
        }
        
        try await TIDocument(tiID: tiID).updateData(chainData)
    }
    
    //MARK: Edit Admins
    func editAdmins(tiID: String, userUID: String, chainDirection: RightOrLeft , addOrRemove: AddOrRemove) async throws {
        
        var adminsData = [String: Any]()
        
        if chainDirection == .right {
            
            if addOrRemove == .add {
                adminsData = [ TI.CodingKeys.rightChainAdminsUIDs.rawValue : FieldValue.arrayUnion([userUID])  ]
            } else if addOrRemove == .remove {
                adminsData = [ TI.CodingKeys.rightChainAdminsUIDs.rawValue : FieldValue.arrayRemove([userUID]) ]
            }
            
        } else if chainDirection == .left {
            
            if addOrRemove == .add {
                adminsData = [ TI.CodingKeys.leftChainAdminsUIDs.rawValue : FieldValue.arrayUnion([userUID])  ]
            } else if addOrRemove == .remove {
                adminsData = [ TI.CodingKeys.leftChainAdminsUIDs.rawValue : FieldValue.arrayRemove([userUID]) ]
            }
        }
        
        try await TIDocument(tiID: tiID).updateData(adminsData)
    }
}
