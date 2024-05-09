//
//  TIPost.swift
//  THEAALiisDebates
//
//  Created by Ali Kadhum on 4/24/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//enum PostType {
//    case text, image, video
//}
struct TIPost: Identifiable, Codable, Hashable {
    
    @DocumentID var documentID: String?
    var id: String
    
    var postType: PostType
    
    var title: String?
    var thumbnailURLString: String?
    var videoURLString: String?
}
