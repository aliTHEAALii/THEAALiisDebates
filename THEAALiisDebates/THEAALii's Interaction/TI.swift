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
    let introPostID: String //same as the TI ID
    
    let creatorUID: String
    var tiAdminsUIDs: [String]

    
    // - Right Side - //
    var rightSideChain: [String: [String]] = [:]

    var rsUserUID        :  String
    var rsLevel1UsersUIDs       : [String] = [] //Team (Main Debaters) (max 3 + user = 4 )
    
    var rsLevel2UsersUIDs       : [String] = [] //Support (Secondary )
    var rsLevel3UsersUIDs       : [String] = [] //Admins  (Tertiary  )

    var rsSponsorsUIDs          : [String: Int] = [:] // [ SponsorUID : $400 ]
    
    var rsVerticalListAccess: VerticalListAccess = .open
    
    // - Left Side - //
    var leftSideChain: [String: [String]] = [:]

    var lsUserUID        :  String?
    var lsLevel1UsersUIDs       : [String] = [] //Team (Main Debaters) (max 3 + user = 4 )
    
    var lsLevel2UsersUIDs       : [String] = [] //Support (secondary )
    var lsLevel3UsersUIDs       : [String] = [] //Admins  (Tertiary  )
    
    var lsSponsorsUIDs          : [String: Int] = [:] // [ SponsorUID : $400 ]
    
    var lsVerticalListAccess: VerticalListAccess = .open
    
    var tiObserversUIDs: [String] = []

    
    
    //MARK: - Coding Keys
    enum CodingKeys: String, CodingKey {
        case id                 = "id"
        case title              = "title"
        case description        = "description"
        case thumbnailURL       = "thumbnail_url"
        case dateCreated        = "date_created"
        
        case tiType             = "ti_type"

        case introPostID        = "intro_post_id"
        case creatorUID         = "creator_uid"
        case tiAdminsUIDs       = "ti_admins_uids"

        // right side Chain
        case rightSideChain       = "right_side_chain"
        case rsUserUID            = "rs_user_uid"
        
        case rsLevel1UsersUIDs    = "rs_level_1_users_uids"
        case rsLevel2UsersUIDs    = "rs_level_2_users_uids"
        case rsLevel3UsersUIDs    = "rs_level_3_users_uids"
        
        case rsSponsorsUIDs       = "rs_sponsors_uids"
        case rsVerticalListAccess = "rs_vertical_list_access"
        
        // left side chain
        case leftSideChain        = "left_side_chain"
        case lsUserUID            = "ls_user_uid"
        
        case lsLevel1UsersUIDs    = "ls_level_1_users_uids"
        case lsLevel2UsersUIDs    = "ls_level_2_users_uids"
        case lsLevel3UsersUIDs    = "ls_level_3_users_uids"
        
        case lsSponsorsUIDs       = "ls_sponsors_uids"
        case lsVerticalListAccess = "ls_vertical_list_access"
        
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
        //right side
        self.rightSideChain = try container.decode([String: [String]].self, forKey: .rightSideChain)
        self.rsUserUID = try container.decode(String.self, forKey: .rsUserUID)
        self.rsLevel1UsersUIDs = try container.decode([String].self, forKey: .rsLevel1UsersUIDs)
        self.rsLevel2UsersUIDs = try container.decode([String].self, forKey: .rsLevel2UsersUIDs)
        self.rsLevel3UsersUIDs = try container.decode([String].self, forKey: .rsLevel3UsersUIDs)
        
        self.rsSponsorsUIDs = try container.decode([String: Int].self, forKey: .rsSponsorsUIDs)
        self.rsVerticalListAccess = try container.decode(VerticalListAccess.self, forKey: .rsVerticalListAccess)

        
        //left side
        self.leftSideChain = try container.decode([String: [String]].self, forKey: .leftSideChain)
        self.lsUserUID = try container.decode(String.self, forKey: .lsUserUID)
        self.lsLevel1UsersUIDs = try container.decode([String].self, forKey: .lsLevel1UsersUIDs)
        self.lsLevel2UsersUIDs = try container.decode([String].self, forKey: .lsLevel2UsersUIDs)
        self.lsLevel3UsersUIDs = try container.decode([String].self, forKey: .lsLevel3UsersUIDs)
        
        self.lsSponsorsUIDs = try container.decode([String: Int].self, forKey: .lsSponsorsUIDs)
        self.lsVerticalListAccess = try container.decode(VerticalListAccess.self, forKey: .lsVerticalListAccess)

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
        
        //right side
        try container.encode(self.rightSideChain, forKey: .rightSideChain)
        try container.encode(self.rsUserUID, forKey: .rsUserUID)
        try container.encode(self.rsLevel1UsersUIDs, forKey: .rsLevel1UsersUIDs)
        try container.encode(self.rsLevel2UsersUIDs, forKey: .rsLevel2UsersUIDs)
        try container.encode(self.rsLevel3UsersUIDs, forKey: .rsLevel3UsersUIDs)

        try container.encode(self.rsSponsorsUIDs, forKey: .rsSponsorsUIDs)
        try container.encode(self.rsVerticalListAccess, forKey: .rsVerticalListAccess)

        //left side
        try container.encode(self.leftSideChain, forKey: .leftSideChain)
        try container.encodeIfPresent(self.lsUserUID, forKey: .lsUserUID)
        try container.encode(self.rsLevel1UsersUIDs, forKey: .rsLevel1UsersUIDs)
        try container.encode(self.rsLevel2UsersUIDs, forKey: .rsLevel2UsersUIDs)
        try container.encode(self.rsLevel3UsersUIDs, forKey: .rsLevel3UsersUIDs)

        try container.encode(self.rsSponsorsUIDs, forKey: .rsSponsorsUIDs)
        try container.encode(self.lsVerticalListAccess, forKey: .lsVerticalListAccess)
        
        try container.encodeIfPresent(self.tiObserversUIDs, forKey: .tiObserversUIDs)
    }
    
    //MARK: - [ inits ] -
    // - create init - //
    // .d1
    init(ID: String, title: String, description: String, thumbnailURL: String?,
         creatorUID: String, tiAdminsUIDs: [String],
        
         rsLevel1UsersUIDs : [String],
         rsLevel2UsersUIDs : [String],
         rsLevel3UsersUIDs : [String],
         
         rsVerticalListAccess: VerticalListAccess
    ) {
        self.documentID = ID
        self.id = ID
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL;
        self.dateCreated = Date.now  //FIXME: Date()
        
        self.tiType = .d1

        self.introPostID = ID
        self.creatorUID = creatorUID; self.tiAdminsUIDs = tiAdminsUIDs
        //chain
        self.rightSideChain = [:]
        self.rsUserUID = creatorUID
        self.rsLevel1UsersUIDs = rsLevel1UsersUIDs
        
        self.rsVerticalListAccess = rsVerticalListAccess
        
        self.tiObserversUIDs = [creatorUID]
    }
    
    //.d2
    init(ID: String, title: String, description: String, thumbnailURL: String?,
         creatorUID: String, tiAdminsUIDs: [String],
         
         //right
         rsUserUID : String          ,
         rsLevel1UsersUIDs : [String],
         rsLevel2UsersUIDs : [String],
         rsLevel3UsersUIDs : [String],
         
         rsVerticalListAccess: VerticalListAccess,
         
         //left
         lsUserUID : String          ,
         lsLevel1UsersUIDs : [String],
         lsLevel2UsersUIDs : [String],
         lsLevel3UsersUIDs : [String],
         
         lsVerticalListAccess: VerticalListAccess
    ) {
        self.documentID = ID
        self.id = ID
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL;
        self.dateCreated = Date.now  //FIXME: Date()
        
        self.tiType = .d2
        
        self.introPostID = ID
        self.creatorUID = creatorUID; self.tiAdminsUIDs = tiAdminsUIDs
        
        //right Side
        self.rightSideChain = [:]
        self.rsUserUID = rsUserUID
        self.rsLevel1UsersUIDs = rsLevel1UsersUIDs
        self.rsLevel2UsersUIDs = rsLevel2UsersUIDs
        self.rsLevel3UsersUIDs = rsLevel3UsersUIDs

        self.rsVerticalListAccess = rsVerticalListAccess
        
        //left side
        self.leftSideChain = [:]
        self.lsUserUID = lsUserUID
        self.lsLevel1UsersUIDs = rsLevel1UsersUIDs
        self.lsLevel2UsersUIDs = rsLevel2UsersUIDs
        self.lsLevel3UsersUIDs = rsLevel3UsersUIDs

        self.lsVerticalListAccess = rsVerticalListAccess
        
        self.tiObserversUIDs = [creatorUID]
    }
    
    // - Read init - //
    init(ID: String, title: String, description: String, thumbnailURL: String?, introPostID: String, 
         creatorUID: String, tiAdminsUIDs: [String], dateCreated: Date,
         tiType: TIType, 
         //right Side
         rightSideChain: [String: [String]],
         rsUserUID : String          ,
         rsLevel1UsersUIDs : [String],
         rsLevel2UsersUIDs : [String],
         rsLevel3UsersUIDs : [String],
         
         rsVerticalListAccess: VerticalListAccess,
         
         
         leftSideChain: [String: [String]],
         lsUserUID : String          ,
         lsLevel1UsersUIDs : [String],
         lsLevel2UsersUIDs : [String],
         lsLevel3UsersUIDs : [String],
         
         lsVerticalListAccess: VerticalListAccess,
         
         tiObserversUIDs: [String]
    ) {
        self.documentID = ID
        self.id = ID
        self.title = title; self.description = description;
        self.thumbnailURL = thumbnailURL; 
        
        self.tiType = tiType

        self.introPostID = introPostID
        self.creatorUID = creatorUID
        self.tiAdminsUIDs = tiAdminsUIDs
        self.dateCreated = dateCreated
        
        //right Side
        self.rightSideChain = rightSideChain
        self.rsUserUID = rsUserUID
        self.rsLevel1UsersUIDs = rsLevel1UsersUIDs
        self.rsLevel2UsersUIDs = rsLevel2UsersUIDs
        self.rsLevel3UsersUIDs = rsLevel3UsersUIDs

        self.rsVerticalListAccess = rsVerticalListAccess
        
        //left side
        self.leftSideChain = leftSideChain
        self.lsUserUID = lsUserUID
        self.lsLevel1UsersUIDs = rsLevel1UsersUIDs
        self.lsLevel2UsersUIDs = rsLevel2UsersUIDs
        self.lsLevel3UsersUIDs = rsLevel3UsersUIDs

        self.lsVerticalListAccess = rsVerticalListAccess
        
        self.tiObserversUIDs = [creatorUID]
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
            chainData = [ TI.CodingKeys.rightSideChain.rawValue : FieldValue.arrayUnion([CLinkID]) ]
            
        } else if rightOrLeft == .left {
            chainData = [ TI.CodingKeys.leftSideChain.rawValue : FieldValue.arrayRemove([CLinkID]) ]
        }
        
        try await TIDocument(tiID: tiID).updateData(chainData)
    }
    
    //FIXME: - This is all wrong (Edit Admins) Obsolete
    //MARK: Edit Admins
    func editAdmins(tiID: String, userUID: String, chainDirection: LeftOrRight , addOrRemove: AddOrRemove) async throws {
        
        var adminsData = [String: Any]()
        
        //FIXME: Removing Admins ??????? (remove
        if chainDirection == .right {
            
            if addOrRemove == .add {
                adminsData = [ TI.CodingKeys.rsLevel1UsersUIDs.rawValue : FieldValue.arrayUnion([userUID])  ]
            } else if addOrRemove == .remove {
                adminsData = [ TI.CodingKeys.rsLevel1UsersUIDs.rawValue : FieldValue.arrayRemove([userUID]) ]
            }
            
        } else if chainDirection == .left {
            
            if addOrRemove == .add {
                adminsData = [ TI.CodingKeys.lsLevel1UsersUIDs.rawValue : FieldValue.arrayUnion([userUID])  ]
            } else if addOrRemove == .remove {
                adminsData = [ TI.CodingKeys.lsLevel1UsersUIDs.rawValue : FieldValue.arrayRemove([userUID]) ]
            }
        }
        
        try await TIDocument(tiID: tiID).updateData(adminsData)
    }
}
