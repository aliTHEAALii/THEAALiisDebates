//
//  TestingComponentsManager.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 4/8/23.
//

import Foundation

final class TestingComponents {
    
//    static let shared = TestingComponents()
//    private init() { }
    
    //MARK: - Images
    let imageURLStringpaulI = "https://hws.dev/paul.jpg"
    let imageURLStringDesignnCode = "https://images.ctfassets.net/ooa29xqb8tix/J6KiaOqQyBtSa84hx6fuI/2cd1d475743a2a42c8643b2a69e88547/Advanced_React_Hooks_800x600_cover.png?w=400&q=50"
    let imageURL = "https://firebasestorage.googleapis.com/v0/b/theaaliidebates.appspot.com/o/Profile_Images%2FuqxQtBAOl0Yj2msXUX1WNzgcBii1?alt=media&token=c182a322-7496-4d45-b788-d50e46c062bd"
    
    //MARK: - TITs
    let testingTIT = TIModel(
//        id: "TIT_tutorial_Interaction_ID",
        id: "10A47E3F-5659-40C9-B14F-A0428390BDFA",
        //10A47E3F-5659-40C9-B14F-A0428390BDFA
        name: "THEAALii's Interaction Technology (TIT)\n Tutorial",
        description: "Welcome to THEAALii Debates.",
        thumbnailURLString: "https://images.ctfassets.net/ooa29xqb8tix/J6KiaOqQyBtSa84hx6fuI/2cd1d475743a2a42c8643b2a69e88547/Advanced_React_Hooks_800x600_cover.png?w=400&q=50",
        creatorUID: "f2i3iO0pSWWn11WlkXrf0gILwyw2",
        administratorsUID: ["person_id", "person_id_2", "person_id_3", "person_id_4", "person_id_5"],
        interactionChain: ["testingChainLink1", "whatever" ,"THree"]
        )
    
    //MARK: - Chain Link
    let testChainLink = TITChainLinkModel(id: "test chain L ID", videoID: "testing bra", responseList: ["1", "w", "h"])
    let testTIChainL = TITChainLModel(id: "id", videoId: "vi", videoTitle: "video title",
                                      videoThumbnail: "https://images.ctfassets.net/ooa29xqb8tix/J6KiaOqQyBtSa84hx6fuI/2cd1d475743a2a42c8643b2a69e88547/Advanced_React_Hooks_800x600_cover.png?w=400&q=50",
                                      responseList: [])
    
    //MARK: - tit Videos
    let titVideo = TIVideoModel(id: "testing bra",
                                 videoURL: "https://firebasestorage.googleapis.com/v0/b/theaaliidebates.appspot.com/o/Videos%2Fvideo1.mp4?alt=media&token=a0cb419d-5e41-47ef-bcf7-ad2d0ff0647c",
                                 thumbnail: "https://images.ctfassets.net/ooa29xqb8tix/J6KiaOqQyBtSa84hx6fuI/2cd1d475743a2a42c8643b2a69e88547/Advanced_React_Hooks_800x600_cover.png?w=400&q=50",
                                 creatorID: "test creator",
                                 name: "Testing tit video",
                                description: "description for testing tit Video", chainLId: "wow")
    
    let titVideo1 = TIVideoModel(id: "mea2", videoURL: "https://firebasestorage.googleapis.com/v0/b/theaaliidebates.appspot.com/o/Videos%2Fvideo1.mp4?alt=media&token=a0cb419d-5e41-47ef-bcf7-ad2d0ff0647c",
                                  thumbnail: "https://hws.dev/paul.jpg",
                                  creatorID: "creator",
                                  name: "Testing TIT Video 1",
                                 description: "This TIT Video is for testing purposes only", chainLId: "wow2"
                                  )
    
    //MARK: - Texts
    let text2 = " Intro to the app what the f is going on here man, woman, other creatures. what is going on here? you must answer"
    let text3 = " Intro to the app what the f is"
    let text = " Intro to the app what the f is going on here man, woman, other creatures."
    
    
//    let user1 = UserModel(userUID: "meaw", email: "meaw@paw", name: "Kat Katerson", bio: "Likes dogs!")
    let user = UserModel(userUID: "meaw", email: "meaw@paw", name: "Kat Katerson", bio: "Likes dogs!", profileImageURL: nil, following: [], followers: [], savedUsers: ["meaw meawerson", "lll", "wow", "mal"], observingTITs: [])
    
    //MARK: - VIDEO
    let videoLink1 = "https://firebasestorage.googleapis.com/v0/b/theaaliidebates.appspot.com/o/Videos%2Fvideo1.mp4?alt=media&token=a0cb419d-5e41-47ef-bcf7-ad2d0ff0647c"
    let videoLink2 = "https://firebasestorage.googleapis.com/v0/b/theaaliidebates.appspot.com/o/Videos%2F4FA33DBB-17BF-407F-BC5D-1953FA2261FD?alt=media&token=1cc635f7-a095-4cff-a14f-bd2613c405a0"
    
    
    //MARK: - TI
    let testTI0 = TI(id: "id", title: "testing TI title", description: "testing ti Description", thumbnailURL: "https://images.ctfassets.net/ooa29xqb8tix/J6KiaOqQyBtSa84hx6fuI/2cd1d475743a2a42c8643b2a69e88547/Advanced_React_Hooks_800x600_cover.png?w=400&q=50"
                     , introCLinkID: "ti video id", creatorUID: "uid", tiAdminsUIDs: [], dateCreated: Date.now.addingTimeInterval(86400), tiType: .d2, rightChain: ["m", "l"], leftChain: ["t", "o", "p"], responseListAccess: .restricted)
    
    let testTI1nil = TI(id: "id", title: "testing TI title", description: "testing ti Description", thumbnailURL: nil //"https://images.ctfassets.net/ooa29xqb8tix/J6KiaOqQyBtSa84hx6fuI/2cd1d475743a2a42c8643b2a69e88547/Advanced_React_Hooks_800x600_cover.png?w=400&q=50"
                        , introCLinkID: "ti video id", creatorUID: "uid", tiAdminsUIDs: [], dateCreated: Date.now.addingTimeInterval(86400), tiType: .d2, rightChain: ["m", "l"], leftChain: ["t", "o", "p"], responseListAccess: .restricted)
    
}
