////
////  THEAALiiInteractionModel.swift
////  TheAaliiDebates
////
////  Created by Ali Abraham on 5/30/23.
////
//
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

enum TIType   : String, Codable { case post = "post",  d1 = "thread", d2 = "vs" }
enum VerticalListAccess: String, Codable { case open = "open", restricted = "restricted", closed = "closed" }
enum LeftOrRight { case left, right }

struct TI: Identifiable, Codable {
    
    @DocumentID var documentID: String?
    var id: String
    
    let title: String
    var description: String                 //FIXME: - Remove
    var thumbnailURL: String?
    let dateCreated: Date

    //FIXME: - change order
    var tiType: TIType = .d1
    
    
//    let introCLinkID: String?               ///date - Chain
    let introPostID: String //same as the TI ID
    
    let creatorUID: String
    var tiAdminsUIDs: [String]

    
    // - Right Side -
    var RightSideChain: [String: [String]] = [:]

    var rsUserUID        :  String
    var rsLevel1UsersUIDs       : [String] = [] //Team (Main Debaters) (max 3 + user = 4 )
    
    var rsLevel2UsersUIDs       : [String] = [] //Support (Secondary )
    var rsLevel3UsersUIDs       : [String] = [] //Admins  (Tertiary  )

    var rsSponsorsUIDs          : [String] = [] // [ SponsorUID : $400 ]
    
    var rsVerticalListAccess: VerticalListAccess = .open
    
    // - Left Side - //
    var leftSideChain: [String: [String]] = [:]

    var lsUserUID        :  String
    var lsLevel1UsersUIDs       : [String] = [] //Team (Main Debaters) (max 3 + user = 4 )
    
    var lsLevel2UsersUIDs       : [String] = [] //Support (secondary )
    var lsLevel3UsersUIDs       : [String] = [] //Admins  (Tertiary  )
    
    var lsSponsorsUIDs          : [String: Int] = [:] // [ SponsorUID : $400 ]
    
    var lsVerticalListAccess: VerticalListAccess = .open

    
    // -------- //
//    var rightChain: [String] = []               //Chain IDs
//    //  var rightChain Admins UIDs
//    var rightChainUsersUIDs: [String] = []
//    
//    var leftChain: [String] = []                //Chain IDs
//    //  var leftChain Admins UIDs
//    var leftChainUsersUIDs: [String] = []
//    
//    var verticalListAccess: VerticalListAccess = .open
//    var verticalListUsersUIDs: [String] = []
    
    var tiObserversUIDs: [String] = []

    //MARK: - [ inits ] -
    // - create init - //
    init(ID: String, title: String, description: String, thumbnailURL: String?, creatorUID: String,
         tiType: TIType, responseListAccess: VerticalListAccess) {
        self.documentID = ID
        self.id = ID
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL;
        self.introPostID = ID
        self.creatorUID = creatorUID; self.tiAdminsUIDs = [creatorUID]
        self.dateCreated = Date()
        self.tiType = tiType; self.rsVerticalListAccess = responseListAccess
    }
    
    // - Read init - //
    init(id: String, title: String, description: String, thumbnailURL: String?, introPostID: String, creatorUID: String, tiAdminsUIDs: [String], dateCreated: Date,
         tiType: TIType, rightChain: [String], leftChain: [String], responseListAccess: VerticalListAccess) {
        self.documentID = id
        self.id = id
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL; self.introPostID = introPostID
        self.creatorUID = creatorUID
        self.tiAdminsUIDs = tiAdminsUIDs
        self.dateCreated = dateCreated
        self.tiType = tiType; self.rightChain = rightChain; self.leftChain = leftChain
        self.verticalListAccess = responseListAccess
    }
    
    //MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case title              = "title"
        case description        = "description"
        case thumbnailURL       = "thumbnail_url"
        case introPostID        = "intro_post_id"
        case creatorUID         = "creator_uid"
        case tiAdminsUIDs       = "ti_admins_uids"
        case dateCreated        = "date_created"
        case tiType             = "ti_type"

        case rightChain           = "right_chain"
        case rightChainAdminsUIDs = "right_chain_users_uids"
        case leftChain            = "left_chain"
        case leftChainAdminsUIDs  = "left_chain_users_uids"
        
        case verticalListAccess    = "vertical_list_access"
        case verticalListUsersUIDs = "vertical_list_users_uids"
        
        case tiObserversUIDs      = "ti_observers_uids"
    }
    
    //MARK: Decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.thumbnailURL = try container.decodeIfPresent(String.self, forKey: .thumbnailURL)
        self.introPostID = try container.decode(String.self, forKey: .introPostID)
        
        self.creatorUID = try container.decode(String.self, forKey: .creatorUID)
        self.tiAdminsUIDs = try container.decode([String].self, forKey: .tiAdminsUIDs)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        
        self.tiType = try container.decode(TIType.self, forKey: .tiType)
        self.rightChain = try container.decode([String].self, forKey: .rightChain)
        self.rightChainUsersUIDs = try container.decode([String].self, forKey: .rightChainAdminsUIDs)
        self.leftChain = try container.decode([String].self, forKey: .leftChain)
        self.leftChainUsersUIDs = try container.decode([String].self, forKey: .leftChainAdminsUIDs)
        
        self.verticalListAccess = try container.decode(VerticalListAccess.self, forKey: .verticalListAccess)
        self.verticalListUsersUIDs = try container.decode([String].self, forKey: .verticalListUsersUIDs)

        self.tiObserversUIDs = try container.decode([String].self, forKey: .tiObserversUIDs)
    }

    //MARK: Encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.thumbnailURL, forKey: .thumbnailURL)
        try container.encode(self.introPostID, forKey: .introPostID)
        try container.encode(self.creatorUID, forKey: .creatorUID)
        try container.encode(self.tiAdminsUIDs, forKey: .tiAdminsUIDs)

        try container.encode(self.dateCreated, forKey: .dateCreated)
        try container.encode(self.tiType, forKey: .tiType)
        
        try container.encode(self.rightChain, forKey: .rightChain)
        try container.encode(self.rightChainUsersUIDs, forKey: .rightChainAdminsUIDs)
        try container.encode(self.leftChain, forKey: .leftChain)
        try container.encode(self.leftChainUsersUIDs, forKey: .leftChainAdminsUIDs)

        try container.encodeIfPresent(self.verticalListAccess, forKey: .verticalListAccess)
        try container.encodeIfPresent(self.verticalListUsersUIDs, forKey: .verticalListUsersUIDs)
        
        try container.encodeIfPresent(self.tiObserversUIDs, forKey: .tiObserversUIDs)
    }
}



//MARK: - [ MANAGER ]
final class TIManager {
    
    static let shared = TIManager()
    private init() { }
    
    //TI Document Location
    private let TICollection: CollectionReference = Firestore.firestore().collection("THEAALii_Interactions") //TIs
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
    func addToChain(tiID: String, CLinkID: String, rightOrLeft: LeftOrRight) async throws {
        var chainData = [String: Any]()
        
        if rightOrLeft == .right {
            chainData = [ TI.CodingKeys.rightChain.rawValue : FieldValue.arrayUnion([CLinkID]) ]
            
        } else if rightOrLeft == .left {
            chainData = [ TI.CodingKeys.rightChain.rawValue : FieldValue.arrayRemove([CLinkID]) ]
        }
        
        try await TIDocument(tiID: tiID).updateData(chainData)
    }
    
    //MARK: Edit Admins
    func editAdmins(tiID: String, userUID: String, chainDirection: LeftOrRight , addOrRemove: AddOrRemove) async throws {
        
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
