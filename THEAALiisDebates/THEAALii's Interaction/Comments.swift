////
////  Comments.swift
////  TheAaliiDebates
////
////  Created by Ali Abraham on 5/30/23.
////
//
//import Foundation
//
//struct CommentsSection: Identifiable {
//
//    @DocumentID var documentID: String?
//    var id: String
//
//    //Comment Model
//    struct Comment: Identifiable {
//        @DocumentID var documentID: String?
//        var id: String
//
//        let creator: String
//        let body: String
//
//        var totalVotes: Int = 0
//        var upVotes: Int = 0
//        var upVotersArray: [String] = []
//        var downVotes: Int = 0
//        var downVotersArray: [String] = []
//    }
//
//    var commentsArray: [Comment] = []
//}
//
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//final class CommentsManager {
//
//    static let shared = CommentsManager()
//    private init() { }
//
//    //Comment Sections Document Location
//    private let TICollection: CollectionReference = Firestore.firestore().collection("THEAALii_Interactions")
//    private func SectionDocument(tiID: String, commentSectionID: String) -> DocumentReference {
//        TICollection.document(tiID).collection("Comment_Sections").document(commentSectionID)
//    }
//
//    //1. - Create
//    func createSection(tiID: String, section: CommentsSection) async throws {
//        SectionDocument(tiID: tiID).setData(from: section, merge: false)
//    }
//
//    //2. - Read
//    func getSection(tiID: String, sectionID: String) async throws {
//        SectionDocument(tiID: tiID).getDocument(as: CommentsSection.self)
//    }
//
//    //3. Update
////    func upDateVoting(tiID: String, sectionID: String, commentID: String, currentUserUID: String, increaseOrDecrease: IncreaseOrDecrease, addOrRemove: AddOrRemove) async throws {
////
////    }
//}
//
