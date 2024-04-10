//
//  ResponseListSV.swift
//  TheAaliiDebates
//
//  Created by Ali Abraham on 5/25/23.
//

import SwiftUI

struct ResponseListSV: View {
    
    let tiId : String
    @Binding var tiChainL: TITChainLModel?
    @State private var responseList: [TIVideoModel] = []
    
    let isAdmin: Bool
    
    var body: some View {
        
        VStack {
            ForEach(responseList) { tiVideo in
                if let tiChainLId = tiChainL?.id {
                    VotingVideoCard(tiID: tiId, tiChainLId: tiChainLId, tiVideoID: tiVideo.id, order: 1, isAdmin: isAdmin)
                }
            }
            
            Rectangle()
                .fill(Color.black)
                .frame(width: width, height: width * 0.5)
            
        }
        .preferredColorScheme(.dark)
        .onAppear { Task { try await fetchResponseList() } }
    }
    
    //MARK: Fetch RL
    func fetchResponseList() async throws {
        if tiChainL != nil {
            print("🫀 fetch RL 🫀")
            Task {
                responseList = try await TITVideoManager.shared.fetchResponseListVideos(tiId: tiId, tiChainLId: tiChainL!.id)
            }
        }
    }
}

struct ResponseListSV_Previews: PreviewProvider {
    static var previews: some View {
        ResponseListSV(tiId: "tiId",
                       tiChainL: .constant(TestingComponents().testTIChainL), isAdmin: true)
    }
}
