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
    
    
    init() { Task { try await fetchTITs() } }
    
    
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
}
