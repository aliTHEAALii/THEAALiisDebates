//
//  ResponseListViewModel.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/2/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


@MainActor
final class ResponseListViewModel: ObservableObject {
    
    @Published var responseListVideos: [TIVideoModel] = []
    
    init() { }
    
    //    func fetchListVideos(listVideos: [TIVideoModel]) async throws {
//    func fetchListVideos(tiID: String, tiChainID: String) async throws {
//
//        responseListVideos.removeAll()
//        //            loading = true
//
//        //            let TITsRef: CollectionReference = Firestore.firestore().collection("Interactions")
//        //        let chainRef: CollectionReference =
//        let chain = try await TITChainLManager.shared.readCLink(titId: tiID, titCLinkId: tiChainID)
//
//        let snapshot = try await TITsRef.getDocuments()
//
//        for document in snapshot.documents {
//            let TIVideo = try document.data(as: TIVideoModel.self)
//            responseListVideos.append(TIVideo)
//        }
//
//        //            loading = false
//
//
//
//    }
    
}



