//
//  FeedViewModel.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/17/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class FeedViewModel: ObservableObject {
    
    @Published var TITs: [TIModel] = []
    @Published var loading: Bool = false
    
    
//    init() { Task { try await fetchTITs() } }
    
    
    func fetchTITs() async throws {
        
        TITs.removeAll()
        loading = true
        
        let TITsRef: CollectionReference = Firestore.firestore().collection("Interactions")
        
        let snapshot = try await TITsRef.getDocuments()
        
        for document in snapshot.documents {
            let TIT = try document.data(as: TIModel.self)
            TITs.append(TIT)
        }
        
        loading = false
    }
    
    func fetchTIs(completion: @escaping (_ tiFeed: [TI] ) -> Void ) async throws {
        
        var tiArray: [TI] = []
        
        let tiRef: CollectionReference = Firestore.firestore().collection("THEAALii_Interactions")
        
        do {
            let snapshot = try await tiRef.getDocuments()
            print("snapshot count = \(snapshot.count)" + " ✅✅🚪🔥🐤🦁")
//            print(snapshot)
            
            for document in snapshot.documents {
                print("snapshot count = \(111)" + " ✅✅🚪🔥🐤🦁")
                
//                print(document)
//                let tipartial = try document.data(as: TIPartial.self)
//                print(tipartial)
                print("snapshot count = \(222)" + " ✅✅🚪🔥🐤🦁")

                let ti = try document.data(as: TI.self)

//                print("snapshot count = \(222)" + " ✅✅🚪🔥🐤🦁")
                
                tiArray.append(ti)
                print("snapshot count = \(333)" + " ✅✅🚪🔥🐤🦁")
                
            }
        } catch {
            completion(tiArray)
            print(error)
        }
        
        completion(tiArray)
        
    }
}

//
//struct TIPartial: Codable {
//    
//    let title: String
//    var thumbnail_url: String? //
//    let dateCreated: Date? //
//    
//    var tiType: TIType? //
//    var introPostID: String? //same as the TI ID
//    
//    let creatorUID: String?
//    var tiAdminsUIDs: [String]?
//    
//    
//    var rightSideChain: [String: [String]]? = [:]
//
//    var rsUserUID        :  String?
//    var rsLevel1UsersUIDs       : [String]? = [] //Team (Main Debaters) (max 3 + user = 4 )
//    
//    var rsLevel2UsersUIDs       : [String]? = [] //Support (Secondary )
//    var rsLevel3UsersUIDs       : [String]? = [] //Admins  (Tertiary  )
//
//    var rsSponsorsUIDs          : [String: Int]? = [:] // [ SponsorUID : $400 ]
//    
//    var rsVerticalListAccess: VerticalListAccess? = .open
//    
//    // - Left Side - //
//    var leftSideChain: [String: [String]]? = [:]
//
//    var ls_user_uid        :  String?
//    var lsLevel1UsersUIDs       : [String]? = [] //Team (Main Debaters) (max 3 + user = 4 )
//    
//    var lsLevel2UsersUIDs       : [String]? = [] //Support (secondary )
//    var lsLevel3UsersUIDs       : [String]? = [] //Admins  (Tertiary  )
//    
//    var lsSponsorsUIDs          : [String: Int]? = [:] // [ SponsorUID : $400 ]
//    
//    var lsVerticalListAccess: VerticalListAccess? = .open
//    
//    var tiObserversUIDs: [String]? = []
//}
